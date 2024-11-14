package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.dto.request.ResetPasswordRequestDTO;
import com.crofle.livecrowdfunding.service.serviceImpl.AccountServiceImpl;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Optional;

@SpringBootTest
@Log4j2
public class LoginServiceTest {
    @Autowired
    private UserService userService;

    @Autowired
    private AccountService accountService;

    @Test
    public void testFindEmail() {
        String name = "권용빈";
        String phone = "123-456-7890";
        Optional<AccountView> email = accountService.findEmailByNameAndPhone(name, phone);

        log.info("\n\n========== 이메일 찾기 결과: " + email + " ==========\n\n");
    }

    @Test
    public void testFindPassword() {
        ResetPasswordRequestDTO resetPasswordDTO = ResetPasswordRequestDTO.builder()
                .email("firstsm41@naver.com")
                .name("권용빈")
                .phone("123-456-7890")
                .build();


        accountService.sendResetPasswordEmail(resetPasswordDTO);

    }
}

