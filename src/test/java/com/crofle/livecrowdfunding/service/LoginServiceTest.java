package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.util.JwtUtil;
import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.domain.enums.Role;
import com.crofle.livecrowdfunding.dto.request.ResetPasswordRequestDTO;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;

import static org.junit.jupiter.api.Assertions.*;

import com.crofle.livecrowdfunding.dto.request.LoginRequestDTO;
import com.crofle.livecrowdfunding.dto.response.TokenDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Base64;
import java.util.Date;
import java.util.Optional;

@SpringBootTest
@Log4j2
public class LoginServiceTest {
    @Autowired
    private UserService userService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private JwtUtil jwtUtil;

    @Test
    @DisplayName("이메일 찾기 테스트")
    public void testFindEmail() {
        // 테스트용 더미 데이터 기준으로 변경
        String name = "김민준";
        String phone = "010-1111-2222";
        Optional<AccountView> result = accountService.findEmailByNameAndPhone(name, phone);

        log.info("\n\n========== 이메일 찾기 결과: " + result + " ==========\n\n");
        assertTrue(result.isPresent());
        assertEquals("minjun@test.com", result.get().getEmail());
    }

    @Test
    @DisplayName("비밀번호 재설정 이메일 발송 테스트")
    public void testFindPassword() {
        // 테스트용 더미 데이터 기준으로 변경
        ResetPasswordRequestDTO resetPasswordDTO = ResetPasswordRequestDTO.builder()
                .email("firstsm41@naver.com")
                .name("권용빈")
                .phone("123-456-7890")
                .build();

        assertDoesNotThrow(() -> accountService.sendResetPasswordEmail(resetPasswordDTO));
    }

    @Test
    @DisplayName("로그인 테스트")
    void testLogin() {
        LoginRequestDTO request = LoginRequestDTO.builder()
                .email("minjun@test.com")
                .password("test123!")
                .build();

        TokenDTO token = accountService.login(request);

        log.info("\n\n========== 로그인 테스트 결과 ==========");
        log.info("Access Token: {}", token.getAccessToken());
        log.info("Refresh Token: {}", token.getRefreshToken());
        log.info("User Email: {}", token.getUserEmail());
        log.info("Role: {}", token.getRole());
        log.info("=====================================\n\n");

        assertNotNull(token.getAccessToken(), "Access Token은 null이 아니어야 합니다");
        assertNotNull(token.getRefreshToken(), "Refresh Token은 null이 아니어야 합니다");
        assertEquals("minjun@test.com", token.getUserEmail());
    }

    @Test
    @DisplayName("토큰 갱신 테스트")
    void testRefreshToken() {
        // 먼저 로그인해서 토큰 받기
        LoginRequestDTO request = LoginRequestDTO.builder()
                .email("minjun@test.com")
                .password("test123!")
                .build();

        TokenDTO loginToken = accountService.login(request);
        log.info("\n\n========== 최초 로그인 토큰 ==========");
        log.info("Original Access Token: {}", loginToken.getAccessToken());
        log.info("Original Refresh Token: {}", loginToken.getRefreshToken());

        TokenDTO refreshedToken = accountService.refresh(loginToken.getRefreshToken());
        log.info("\n\n========== 갱신된 토큰 ==========");
        log.info("New Access Token: {}", refreshedToken.getAccessToken());
        log.info("New Refresh Token: {}", refreshedToken.getRefreshToken());
        log.info("User Email: {}", refreshedToken.getUserEmail());
        log.info("Role: {}", refreshedToken.getRole());
        log.info("=====================================\n\n");

        assertNotNull(refreshedToken.getAccessToken(), "새 Access Token은 null이 아니어야 합니다");
        assertNotNull(refreshedToken.getRefreshToken(), "새 Refresh Token은 null이 아니어야 합니다");
        assertEquals("minjun@test.com", refreshedToken.getUserEmail());
        assertNotEquals(loginToken.getAccessToken(), refreshedToken.getAccessToken(), "새로운 Access Token은 이전 것과 달라야 합니다");
    }

    @Test
    @DisplayName("토큰 유효성 검증 테스트")
    void testTokenValidation() {
        LoginRequestDTO request = LoginRequestDTO.builder()
                .email("minjun@test.com")
                .password("test123!")
                .build();

        TokenDTO token = accountService.login(request);

        log.info("\n\n========== 토큰 검증 테스트 ==========");
        log.info("Access Token 유효성: {}", jwtUtil.validateToken(token.getAccessToken()));
        log.info("Refresh Token 유효성: {}", jwtUtil.validateToken(token.getRefreshToken()));

        String email = jwtUtil.getEmailFromToken(token.getAccessToken());
        Role role = jwtUtil.getRoleFromToken(token.getAccessToken());

        log.info("토큰에서 추출한 이메일: {}", email);
        log.info("토큰에서 추출한 역할: {}", role);
        log.info("=====================================\n\n");

        assertTrue(jwtUtil.validateToken(token.getAccessToken()));
        assertTrue(jwtUtil.validateToken(token.getRefreshToken()));
        assertEquals("minjun@test.com", email);
    }

    @Test
    @DisplayName("비밀번호 재설정 이메일 발송 테스트")
    void testPasswordReset() {
        // 비밀번호 재설정 요청
        ResetPasswordRequestDTO resetRequest = ResetPasswordRequestDTO.builder()
                .email("minjun@test.com")
                .name("김민준")
                .phone("010-1111-2222")
                .build();

        log.info("\n\n========== 비밀번호 재설정 요청 ==========");
        accountService.sendResetPasswordEmail(resetRequest);

        // 토큰 생성 및 검증 테스트
        String resetToken = jwtUtil.createPasswordResetToken(resetRequest.getEmail());
        log.info("Password Reset Token: {}", resetToken);

        // 토큰 검증
        boolean isValid = jwtUtil.validateToken(resetToken);
        log.info("Token Validation Result: {}", isValid);

        // 토큰에서 이메일 추출
        String emailFromToken = jwtUtil.getEmailFromToken(resetToken);
        log.info("Email from Token: {}", emailFromToken);

        // 토큰내용 확인이라능
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(Base64.getDecoder().decode(jwtUtil.getSecretKey()))  // getSigningKey 대신 secretKey 사용
                .build()
                .parseClaimsJws(resetToken)
                .getBody();

        log.info("Token Type: {}", claims.get("type"));
        log.info("Token Expiration: {}", claims.getExpiration());
        log.info("=====================================\n\n");

        assertTrue(isValid, "토큰이 유효해야 합니다");
        assertEquals("minjun@test.com", emailFromToken, "토큰에서 추출한 이메일이 일치해야 합니다");
        assertEquals("password_reset", claims.get("type"), "토큰 타입이 password_reset이어야 합니다");
        assertTrue(claims.getExpiration().after(new Date()), "토큰이 만료되지 않아야 합니다");
    }

}