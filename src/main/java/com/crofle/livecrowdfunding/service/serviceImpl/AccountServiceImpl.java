package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.domain.enums.UserStatus;
import com.crofle.livecrowdfunding.dto.request.*;
import com.crofle.livecrowdfunding.repository.UserRepository;
import com.crofle.livecrowdfunding.util.JwtUtil;
import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.domain.enums.Role;
import com.crofle.livecrowdfunding.dto.response.AccountTokenResponseDTO;
import com.crofle.livecrowdfunding.repository.AccountViewRepository;
import com.crofle.livecrowdfunding.service.AccountService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@Log4j2
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {
    private final AccountViewRepository accountViewRepository;
    private final EmailService emailService;
    private final JwtUtil jwtUtil;
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;

    @Override
    public AccountTokenResponseDTO login(AccountLoginRequestDTO request) {
        AccountView account = accountViewRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new IllegalArgumentException("Invalid email or password"));

        log.info("사용된 PasswordEncoder 클래스: {}", passwordEncoder.getClass().getName());
        log.info("Found account: {}", account);
        log.info("Input password: {}, Stored password: {}", request.getPassword(), account.getPassword());

        boolean passwordMatch = passwordEncoder.matches(request.getPassword(), account.getPassword());
        log.info("Password match result: {}", passwordMatch);

        if (!passwordMatch) {
            throw new IllegalArgumentException("Invalid email or password");
        }

        String accessToken = jwtUtil.createAccessToken(account.getEmail(), account.getRole());
        String refreshToken = jwtUtil.createRefreshToken(account.getEmail(), account.getRole());

        return AccountTokenResponseDTO.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .userEmail(account.getEmail())
                .role(account.getRole())
                .build();
    }

    @Override
    public AccountTokenResponseDTO refresh(AccountTokenRequestDTO request) {
        // 1. 리프레시 토큰 검증
        if (!jwtUtil.validateToken(request.getRefreshToken())) {
            throw new IllegalArgumentException("Invalid refresh token");
        }

        // 2. 리프레시 토큰에서 사용자 정보 추출
        String email = jwtUtil.getEmailFromToken(request.getRefreshToken());
        Role role = jwtUtil.getRoleFromToken(request.getRefreshToken());

        // 3. 실제 사용자가 존재하는지 한번 더 확인
        AccountView account = accountViewRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // 4. 새로운 토큰 쌍 생성 (강제로 시간 차이를 주어 다른 토큰이 생성되도록 함)
        try {
            // 0.1초 대기하여 토큰의 발행 시간이 다르게 설정되도록 함
            Thread.sleep(100);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        // 5. 새로운 토큰 생성
        String newAccessToken = jwtUtil.createAccessToken(account.getEmail(), account.getRole());
        String newRefreshToken = jwtUtil.createRefreshToken(account.getEmail(), account.getRole());

        return AccountTokenResponseDTO.builder()
                .accessToken(newAccessToken)
                .refreshToken(newRefreshToken)
                .userEmail(account.getEmail())
                .role(account.getRole())
                .build();
    }

    @Override
    public void logout(String email) {
        log.info("User logged out: {}", email);
    }

    @Override
    public Optional<AccountView> findEmailByNameAndPhone(AccountFindEmailRequestDTO request) {
        return accountViewRepository.findEmailByNameAndPhone(request.getName(), request.getPhone());
    }

    @Override
    public void sendResetPasswordEmail(AccountPasswordResetRequestDTO request) {
        String email = accountViewRepository.findEmailByNameAndMailAndPhone(
                request.getName(),
                request.getEmail(),
                request.getPhone()
        ).orElse(null);

        if (email != null) {
            String resetToken = jwtUtil.createPasswordResetToken(email);
            String resetLink = String.format(
                    "https://your-frontend-domain.com/reset-password?token=%s&email=%s",
                    resetToken, email
            );

            String subject = "비밀번호 재설정 안내";
            String content = String.format(
                    "안녕하세요, %s님\n비밀번호 재설정을 위해 아래 링크를 클릭해주세요:\n%s\n링크는 15분간 유효합니다.",
                    request.getName(), resetLink
            );

            emailService.sendEmail(email, subject, content);
        }
    }

    @Override
    public AccountTokenResponseDTO authenticateOAuthAccount(AccountOAuthRequestDTO request) {
        AccountView account = accountViewRepository.findByEmail(request.getEmail())
                .orElseGet(() -> {
                    // Create new user for OAuth
                    User newUser = User.builder()
                            .name(request.getName())
                            .email(request.getEmail())
                            .password(passwordEncoder.encode(UUID.randomUUID().toString()))
                            .loginMethod(true)
                            .phone("NOT_PROVIDED")
                            .gender(true)
                            .birth("19000101")
                            .zipcode(0)
                            .address("NOT_PROVIDED")
                            .detailAddress("NOT_PROVIDED")
                            .status(UserStatus.활성화)
                            .registeredAt(LocalDateTime.now())
                            .build();
                    userRepository.save(newUser);

                    // Return account view for new user
                    return accountViewRepository.findByEmail(request.getEmail())
                            .orElseThrow(() -> new RuntimeException("Failed to create OAuth account"));
                });

        String accessToken = jwtUtil.createAccessToken(account.getEmail(), account.getRole());
        String refreshToken = jwtUtil.createRefreshToken(account.getEmail(), account.getRole());

        return AccountTokenResponseDTO.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .userEmail(account.getEmail())
                .role(account.getRole())
                .build();
    }
}