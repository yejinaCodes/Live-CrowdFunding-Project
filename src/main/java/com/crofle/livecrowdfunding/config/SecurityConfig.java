package com.crofle.livecrowdfunding.config;
import com.crofle.livecrowdfunding.domain.enums.Role;
import com.crofle.livecrowdfunding.service.AccountService;
import com.crofle.livecrowdfunding.util.JwtUtil;
import com.crofle.livecrowdfunding.dto.request.AccountOAuthRequestDTO;
import com.crofle.livecrowdfunding.dto.response.AccountTokenResponseDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.web.util.UriComponentsBuilder;
import java.util.Arrays;
import java.util.Map;
import java.io.IOException;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final JwtUtil jwtUtil;
    private final AccountService accountService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/api/account/login", "/api/account/refresh").permitAll()
                        .requestMatchers("/oauth2/**", "/login/**").permitAll()
                        .anyRequest().authenticated())
                .oauth2Login(oauth2 -> oauth2
                        .userInfoEndpoint(userInfo -> userInfo
                                .userService(customOAuth2UserService()))
                        .successHandler(oAuth2AuthenticationSuccessHandler()));

        return http.build();
    }

    @Bean
    public OAuth2UserService<OAuth2UserRequest, OAuth2User> customOAuth2UserService() {
        return userRequest -> {
            DefaultOAuth2UserService delegate = new DefaultOAuth2UserService();
            OAuth2User oauth2User = delegate.loadUser(userRequest);

            // 네이버에서 받은 사용자 정보
            Map<String, Object> attributes = oauth2User.getAttributes();
            Map<String, Object> responseData = (Map<String, Object>) attributes.get("response");  // response -> responseData

            String email = (String) responseData.get("email");  // response -> responseData
            String name = (String) responseData.get("name");    // response -> responseData

            // AccountService를 통해 인증 처리
            AccountOAuthRequestDTO authRequest = AccountOAuthRequestDTO.builder()
                    .email(email)
                    .name(name)
                    .role(Role.USER)
                    .build();

            AccountTokenResponseDTO tokenResponse = accountService.authenticateOAuthAccount(authRequest);

            return oauth2User;
        };
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost:3000"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

    @Bean
    public AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler() {
        return new SimpleUrlAuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request,
                                                HttpServletResponse response,
                                                Authentication authentication) throws IOException {
                OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();
                Map<String, Object> attributes = oauth2User.getAttributes();
                Map<String, Object> responseData = (Map<String, Object>) attributes.get("response");  // response -> responseData

                String email = (String) responseData.get("email");  // response -> responseData
                String name = (String) responseData.get("name");    // response -> responseData

                // AccountService를 통해 토큰 발급
                AccountOAuthRequestDTO authRequest = AccountOAuthRequestDTO.builder()
                        .email(email)
                        .name(name)
                        .role(Role.USER)
                        .build();

                AccountTokenResponseDTO tokenResponse = accountService.authenticateOAuthAccount(authRequest);

                // 프론트엔드로 리다이렉트 (토큰 포함)
                String targetUrl = UriComponentsBuilder.fromUriString("http://localhost:3000/oauth2/redirect")
                        .queryParam("token", tokenResponse.getAccessToken())
                        .queryParam("refreshToken", tokenResponse.getRefreshToken())
                        .build().toUriString();

                getRedirectStrategy().sendRedirect(request, response, targetUrl);
            }
        };
    }
}