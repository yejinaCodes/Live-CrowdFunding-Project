package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.SaveMakerDTO;
import com.crofle.livecrowdfunding.dto.SaveUserDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Arrays;

@SpringBootTest
@Log4j2
public class SaveServiceTest {
    @Autowired
    private UserService userService;

    @Test
    public void testUserSave() {
        SaveUserDTO saveUserDTO = SaveUserDTO.builder()

                .name("권용빈")
                .nickname("곽바철")
                .phone("123-456-2890").password("1234")

                .gender(true)
                .birth("1919-04-01")
                .email("2212@naver.com")
                .zipcode(12345)
                .address("123 Street")
                .detailAddress("Apt 101")
                .loginMethod(false)
                .notification(true)
                .notification(true)
                .categoryIds(Arrays.asList(1L, 2L))
                .build();

        SaveUserDTO savedUser = userService.saveUser(saveUserDTO);

        log.info("저장된 사용자 정보: " + savedUser);
        log.info("선택된 카테고리 IDs: " + savedUser.getCategoryIds());


        assert savedUser.getCategoryIds() != null : "카테고리 정보가 null입니다";
        assert !savedUser.getCategoryIds().isEmpty() : "카테고리 정보가 비어있습니다";
    }

    ;

    @Test
    public void testMakerSave() {
        SaveMakerDTO saveMakerDTO = SaveMakerDTO.builder()
                .name("권용빈")
                .phone("123-456-2890")
                .business(11211211)
                .email("firstsm41@gmain.com")
                .password("1234")
                .zipcode(12345)
                .address("123 Street")
                .detailAddress("Apt 101")
                .build();

        SaveMakerDTO saveMaker = userService.saveMaker(saveMakerDTO);

        log.info("저장된 제작자 정보: " + saveMaker);

        assert saveMaker != null : "제작자 정보가 null입니다";
        assert !saveMaker.getName().isEmpty() : "제작자 이름이 비어있습니다";
    }
}