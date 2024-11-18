package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.request.SaveMakerRequestDTO;
import com.crofle.livecrowdfunding.dto.request.SaveUserRequestDTO;
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
    private MakerService makerService;

    @Test
    public void testUserSave() {
        SaveUserRequestDTO saveUserRequestDTO = SaveUserRequestDTO.builder()

                .name("최성민")
                .nickname("CSM")
                .phone("123-456-2890")
                .password("1234")
                .gender(true)
                .birth("1919-04-01")
                .email("11g1@naver.com")
                .zipcode(12345)
                .address("123 Street")
                .detailAddress("Apt 101")
                .loginMethod(false)
                .notification(true)
                .notification(true)
                .categoryIds(Arrays.asList(1L, 2L))
                .build();

        SaveUserRequestDTO savedUser = userService.saveUser(saveUserRequestDTO);

        log.info("저장된 사용자 정보: " + savedUser);
        log.info("선택된 카테고리 IDs: " + savedUser.getCategoryIds());


        assert savedUser.getCategoryIds() != null : "카테고리 정보가 null입니다";
        assert !savedUser.getCategoryIds().isEmpty() : "카테고리 정보가 비어있습니다";
    }

    ;

    @Test
    public void testMakerSave() {
        SaveMakerRequestDTO saveMakerRequestDTO = SaveMakerRequestDTO.builder()
                .name("권용빈")
                .phone("123-456-2890")
                .business(11211211)
                .email("1234341@gmain.com")
                .password("1234")
                .zipcode(12345)
                .address("123 Street")
                .detailAddress("Apt 101")
                .build();

        SaveMakerRequestDTO saveMaker = makerService.saveMaker(saveMakerRequestDTO);

        log.info("저장된 제작자 정보: " + saveMaker);

        assert saveMaker != null : "제작자 정보가 null입니다";
        assert !saveMaker.getName().isEmpty() : "제작자 이름이 비어있습니다";
    }

    ;
}