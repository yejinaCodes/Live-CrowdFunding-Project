package com.crofle.livecrowdfunding.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeRequests(authorizeRequests ->
                        authorizeRequests
                                .requestMatchers("/api/projects").permitAll()  // /api/projects 경로에 대해 인증 비활성화
                                .anyRequest().authenticated()  // 다른 모든 요청은 인증 필요
                )
                .csrf(csrf -> csrf.disable());  // CSRF 비활성화 (Spring Security 6.x 이상)

        return http.build();
    }
}