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
import org.springframework.security.oauth2.core.OAuth2Error;
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
import lombok.extern.slf4j.Slf4j;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@Slf4j
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
                        // 기존 엔드포인트
                        .requestMatchers("/api/account/login", "/api/account/refresh").permitAll()
                        // OAuth 관련 엔드포인트
                        .requestMatchers("/oauth2/**", "/login/**").permitAll()
                        .requestMatchers("/api/oauth2/**").permitAll()
                        // 소셜 로그인 콜백 URL
                        .requestMatchers("/login/oauth2/code/**").permitAll()
                        // Swagger UI 관련 엔드포인트 (있다면)
                        .requestMatchers("/swagger-ui/**", "/v3/api-docs/**").permitAll()
                        // 그 외 모든 요청은 인증 필요
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

            try {
                log.debug("OAuth2User attributes: {}", oauth2User.getAttributes());

                // 네이버에서 받은 사용자 정보
                Map<String, Object> attributes = oauth2User.getAttributes();
                Map<String, Object> responseData = (Map<String, Object>) attributes.get("response");

                String email = (String) responseData.get("email");
                String name = (String) responseData.get("name");

                // AccountService를 통해 인증 처리
                AccountOAuthRequestDTO authRequest = AccountOAuthRequestDTO.builder()
                        .email(email)
                        .name(name)
                        .role(Role.USER)
                        .build();

                AccountTokenResponseDTO tokenResponse = accountService.authenticateOAuthAccount(authRequest);
                log.debug("OAuth2 authentication successful for email: {}", email);

                return oauth2User;
            } catch (Exception e) {
                log.error("Error processing OAuth2User: ", e);
                throw new OAuth2AuthenticationException(
                        new OAuth2Error("processing_error", "Failed to process OAuth2User", null),
                        e
                );
            }
        };
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost:5173"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);
        configuration.setExposedHeaders(Arrays.asList("Authorization"));

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
                try {
                    OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();
                    Map<String, Object> attributes = oauth2User.getAttributes();
                    Map<String, Object> responseData = (Map<String, Object>) attributes.get("response");

                    String email = (String) responseData.get("email");
                    String name = (String) responseData.get("name");

                    log.debug("Processing OAuth2 success: email={}, name={}", email, name);

                    // AccountService를 통해 토큰 발급
                    AccountOAuthRequestDTO authRequest = AccountOAuthRequestDTO.builder()
                            .email(email)
                            .name(name)
                            .role(Role.USER)
                            .build();

                    AccountTokenResponseDTO tokenResponse = accountService.authenticateOAuthAccount(authRequest);

                    // 프론트엔드로 리다이렉트 (토큰 포함)
                    String targetUrl = UriComponentsBuilder.fromUriString("http://localhost:5173/oauth2/redirect")
                            .queryParam("token", tokenResponse.getAccessToken())
                            .queryParam("refreshToken", tokenResponse.getRefreshToken())
                            .build().toUriString();

                    log.debug("Redirecting to: {}", targetUrl);
                    getRedirectStrategy().sendRedirect(request, response, targetUrl);
                } catch (Exception e) {
                    log.error("Error in OAuth2 success handler: ", e);
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Authentication failed");
                }
            }
        };
    }
}