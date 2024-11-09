package com.crofle.livecrowdfunding;

import com.crofle.livecrowdfunding.domain.entity.EssentialDocument;
import com.crofle.livecrowdfunding.domain.entity.RatePlan;
import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.domain.enums.UserStatus;
import com.crofle.livecrowdfunding.repository.RatePlanRepository;
import com.crofle.livecrowdfunding.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@SpringBootTest
@Rollback(false)
public class TestEntity {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RatePlanRepository ratePlanRepository;

    @Test
    public void ratePlanTest(){
        RatePlan ratePlanAdd = RatePlan.builder()
                .planName("Ultimate")
                .charge(Boolean.TRUE)
                .build();
        RatePlan savePlan = ratePlanRepository.save(ratePlanAdd);
        RatePlan findPlan = ratePlanRepository.findById(savePlan.getId())
                .orElseThrow( ()-> new RuntimeException("nope"));
        System.out.println(savePlan.getId());
        System.out.println(findPlan.getPlanName() + " price: " + findPlan.getCharge());
    }

    @Test
    public void essentialDocTest(){
        EssentialDocument essentialDocument = EssentialDocument.builder()

                .build();

    }

    @Test
    public void userEntityTest() {
        User user = User.builder()
                .name("테스트유저33")
                .nickname("테스트닉네임")
                .phone("010-1234-5678")
                .gender(true)
                .birth("19900101")
                .email("test4@test.com")
                .password("Test123!@")
                .zipcode(12345)
                .address("서울시 강남구")
                .detailAddress("테헤란로 123")
                .loginMethod(true)
                .status(UserStatus.활성화)
                .notification(true)
                .registeredAt(LocalDateTime.now())
                .build();

        User savedUser = userRepository.save(user);

        User foundUser = userRepository.findById(savedUser.getId())
                .orElseThrow(() -> new RuntimeException("왜 없지"));

        System.out.println("Saved User ID: " + savedUser.getId());
        System.out.println("Saved User Email: " + foundUser.getEmail());
    }
}
