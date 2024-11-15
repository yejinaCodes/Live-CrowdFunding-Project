package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.config.JwtUtil;
import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.domain.enums.Role;
import com.crofle.livecrowdfunding.dto.request.LoginRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ResetPasswordRequestDTO;
import com.crofle.livecrowdfunding.dto.response.TokenDTO;
import com.crofle.livecrowdfunding.repository.AccountViewRepository;
import com.crofle.livecrowdfunding.repository.CategoryRepository;
import com.crofle.livecrowdfunding.repository.MakerRepository;
import com.crofle.livecrowdfunding.repository.UserRepository;
import com.crofle.livecrowdfunding.service.AccountService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Log4j2
@RequiredArgsConstructor
public class AccountServiceImpl implements AccountService {
    private final AccountViewRepository accountViewRepository;
    private final EmailService emailService;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;
    private final CategoryRepository categoryRepository;
    private final MakerRepository makerRepository;
    private final JwtUtil jwtUtil;


    @Override
    public TokenDTO login(LoginRequestDTO loginRequest) {
        AccountView account = accountViewRepository.findByEmail(loginRequest.getEmail())
                .orElseThrow(() -> new IllegalArgumentException("Invalid email or password"));

        if (!account.getPassword().equals(loginRequest.getPassword())) {
            throw new IllegalArgumentException("Invalid email or password");
        }

        String accessToken = jwtUtil.createAccessToken(account.getEmail(), account.getRole());
        String refreshToken = jwtUtil.createRefreshToken(account.getEmail(), account.getRole());

        return TokenDTO.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .userEmail(account.getEmail())
                .role(account.getRole())
                .build();
    }

    @Override
    public TokenDTO refresh(String refreshToken) {
        if (!jwtUtil.validateToken(refreshToken)) {
            throw new IllegalArgumentException("Invalid refresh token");
        }

        String email = jwtUtil.getEmailFromToken(refreshToken);
        Role role = jwtUtil.getRoleFromToken(refreshToken);

        // 새로운 토큰 생성할 때 약간의 지연시간을 추가
        try {
            Thread.sleep(1000); // 1초 지연
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        String newAccessToken = jwtUtil.createAccessToken(email, role);
        String newRefreshToken = jwtUtil.createRefreshToken(email, role);

        return TokenDTO.builder()
                .accessToken(newAccessToken)
                .refreshToken(newRefreshToken)
                .userEmail(email)
                .role(role)
                .build();
    }


    @Override
    public void sendResetPasswordEmail(ResetPasswordRequestDTO request) {
        String email = accountViewRepository.findEmailByNameAndMailAndPhone(request.getName(), request.getEmail(), request.getPhone());

        if (email != null) {
            // 비밀번호 재설정 토큰 생성
            String resetToken = jwtUtil.createPasswordResetToken(email);
            String resetPasswordLink = generateResetPasswordLink(email, resetToken);

            String subject = "비밀번호 재설정 안내";
            String content = String.format("""
               안녕하세요, %s님
               비밀번호 재설정을 요청하셨습니다.
               아래 링크를 클릭하여 비밀번호를 재설정해 주세요:
               
               %s
               
               링크는 15분 동안 유효합니다.
               """, request.getName(), resetPasswordLink);

            emailService.sendEmail(email, subject, content);
            log.info("\n\n비밀번호 재설정 이메일 발송 완료: {}\n\n", email);
        } else {
            log.warn("\n\n사용자를 찾을 수 없습니다. 이름: {}, 이메일: {}, 전화번호: {}\n\n",
                    request.getName(), request.getEmail(), request.getPhone());
        }
    }

    @Override
    public String generateResetPasswordLink(String email, String resetToken) {
        return String.format("https://your-frontend-domain.com/reset-password?token=%s&email=%s",
                resetToken, email);
    }

    // 이메일 찾기
    @Transactional(readOnly = true)
    @Override
    public Optional<AccountView> findEmailByNameAndPhone(String name, String    phone) {
        return accountViewRepository.findEmailByNameAndPhone(name, phone);
    }

}
