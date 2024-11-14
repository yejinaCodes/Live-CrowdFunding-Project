package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.SaveMakerDTO;
import com.crofle.livecrowdfunding.dto.SaveUserDTO;
import com.crofle.livecrowdfunding.dto.request.UserInfoRequestDTO;
import com.crofle.livecrowdfunding.dto.response.UserInfoResponseDTO;
import org.springframework.transaction.annotation.Transactional;

public interface UserService {

     UserInfoResponseDTO findUser(Long userId);

     void updateUser(UserInfoRequestDTO userInfoRequestDTO);

     void deleteUser(Long userId);


     SaveUserDTO saveUser(SaveUserDTO saveUserDTO);

     SaveMakerDTO saveMaker(SaveMakerDTO saveMakerDTO);


     // 이메일 찾기
     @Transactional(readOnly = true)
     String findEmailByNameAndPhoneNumber(String name, String phoneNumber);
}