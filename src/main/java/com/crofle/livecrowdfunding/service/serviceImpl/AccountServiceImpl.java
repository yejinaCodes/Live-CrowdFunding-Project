package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.dto.request.ResetPasswordRequestDTO;
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


    @Override
    public void sendResetPasswordEmail(ResetPasswordRequestDTO request) {
        // 이름, 이메일, 전화번호로 사용자 이메일 검색
        String email = accountViewRepository.findEmailByNameAndMailAndPhone(request.getName(), request.getEmail(), request.getPhone());

        if (email != null) {
            String resetPasswordLink = generateResetPasswordLink(email); // 비밀번호 재설정 링크 생성
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
            log.warn("\n\n사용자를 찾을 수 없습니다. 이름: {}, 이메일: {}, 전화번호: {}\n\n", request.getName(), request.getEmail(), request.getPhone());
        }
    }

    @Override
    public String generateResetPasswordLink(String email) {
        String token = "이거슨 무시무시한 토큰"; //  토큰 생성할거임
        return "https://example.com/reset-password?token=" + token + "&email=" + email;
    }

    // 이메일 찾기
    @Transactional(readOnly = true)
    @Override
    public Optional<AccountView> findEmailByNameAndPhone(String name, String phone) {
        return accountViewRepository.findEmailByNameAndPhone(name, phone);
    }

}
