package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Category;
import com.crofle.livecrowdfunding.domain.entity.Maker;
import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.domain.entity.UserInterest;
import com.crofle.livecrowdfunding.domain.id.UserCategoryId;
import com.crofle.livecrowdfunding.dto.SaveMakerDTO;
import com.crofle.livecrowdfunding.dto.SaveUserDTO;
import com.crofle.livecrowdfunding.dto.request.UserInfoRequestDTO;
import com.crofle.livecrowdfunding.dto.response.UserInfoResponseDTO;
import com.crofle.livecrowdfunding.repository.CategoryRepository;
import com.crofle.livecrowdfunding.repository.MakerRepository;
import com.crofle.livecrowdfunding.repository.UserRepository;
import com.crofle.livecrowdfunding.repository.UserViewRepository;
import com.crofle.livecrowdfunding.service.UserService;
import com.crofle.livecrowdfunding.domain.enums.UserStatus;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j2
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final ModelMapper modelMapper;
    private final CategoryRepository categoryRepository;
    private final MakerRepository makerRepository;
    private final UserViewRepository userViewRepository;

    @Override
    @Transactional(readOnly = true)
    public UserInfoResponseDTO findUser(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));

        return modelMapper.map(user, UserInfoResponseDTO.class);
    }

    @Override
    @Transactional
    public void updateUser(UserInfoRequestDTO userInfoRequestDTO) {
        User user = userRepository.findById(userInfoRequestDTO.getId()).orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));

        user.updateUserInfo(userInfoRequestDTO);
    }

    @Override
    @Transactional
    public void deleteUser(Long userId) {

    }

    @Transactional
    @Override
    public SaveUserDTO saveUser(SaveUserDTO saveUserDTO) {

        User user = User.builder()
                .name(saveUserDTO.getName())
                .nickname(saveUserDTO.getNickname())
                .phone(saveUserDTO.getPhone())
                .gender(saveUserDTO.getGender())
                .birth(saveUserDTO.getBirth())
                .email(saveUserDTO.getEmail())
                .password(saveUserDTO.getPassword())
                .zipcode(saveUserDTO.getZipcode())
                .address(saveUserDTO.getAddress())
                .detailAddress(saveUserDTO.getDetailAddress())
                .loginMethod(saveUserDTO.getLoginMethod())
                .notification(saveUserDTO.getNotification())
                .status(UserStatus.활성화)
                .registeredAt(LocalDateTime.now())
                .build();


        user = userRepository.save(user);
        log.info("사용자 기본 정보 저장 완료");


        if (saveUserDTO.getCategoryIds() != null && !saveUserDTO.getCategoryIds().isEmpty()) {
            List<UserInterest> interests = new ArrayList<>();

            for (Long categoryId : saveUserDTO.getCategoryIds()) {
                Category category = categoryRepository.findById(categoryId)
                        .orElseThrow(() -> new IllegalArgumentException("유효하지 않은 카테고리 ID: " + categoryId));

                // UserCategoryId 생성
                UserCategoryId userCategoryId = new UserCategoryId(user.getId(), category.getId());

                // UserInterest 생성
                UserInterest interest = UserInterest.builder()
                        .id(userCategoryId)
                        .user(user)
                        .category(category)
                        .build();

                interests.add(interest);
            }

            user.setInterests(interests);
            userRepository.save(user);
            log.info("사용자 관심사 정보 저장 완료");




        }

        return saveUserDTO;
    }

    //사용자(구매자)회원가입
    @Override
    public SaveMakerDTO saveMaker(SaveMakerDTO saveMakerDTO) {

        Maker maker = Maker.builder()
                .name(saveMakerDTO.getName())
                .phone(saveMakerDTO.getPhone())
                .business(saveMakerDTO.getBusiness())
                .email(saveMakerDTO.getEmail())
                .password(saveMakerDTO.getPassword())
                .zipcode(saveMakerDTO.getZipcode())
                .address(saveMakerDTO.getAddress())
                .detailAddress(saveMakerDTO.getDetailAddress())
                .registeredAt(LocalDateTime.now())
                .status(0)
                .build();

        maker = makerRepository.save(maker);
        log.info("메이커 정보 저장 완료");

        return saveMakerDTO;
    }


    // 이메일 찾기
    @Transactional(readOnly = true)
    @Override
    public String findEmailByNameAndPhoneNumber(String name, String phone) {
        return userViewRepository.findEmailByNameAndPhoneNumber(name, phone);
    }


}