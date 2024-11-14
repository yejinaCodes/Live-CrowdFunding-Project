package com.crofle.livecrowdfunding.service;


import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Log4j2
public class LoginServiceTest {
    @Autowired
    private UserService userService;

    @Test
    public void testFindEmail() {
        String name = "김철수";
        String phone = "010-1234-5678";
        String email = userService.findEmailByNameAndPhoneNumber(name, phone);

        log.info("\n\n========== 이메일 찾기 결과: " + email + " ==========\n\n");





    }
}

