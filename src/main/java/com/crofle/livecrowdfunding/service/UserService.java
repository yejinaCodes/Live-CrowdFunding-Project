package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.request.SaveMakerRequestDTO;
import com.crofle.livecrowdfunding.dto.request.SaveUserRequestDTO;
import com.crofle.livecrowdfunding.dto.request.UserInfoRequestDTO;
import com.crofle.livecrowdfunding.dto.response.UserInfoResponseDTO;
import org.springframework.transaction.annotation.Transactional;

public interface UserService {

     UserInfoResponseDTO findUser(Long userId);

     void updateUser(Long id, UserInfoRequestDTO userInfoRequestDTO);

     void deleteUser(Long userId);


     SaveUserRequestDTO saveUser(SaveUserRequestDTO saveUserRequestDTO);

     SaveMakerRequestDTO saveMaker(SaveMakerRequestDTO saveMakerRequestDTO);


     // 이메일 찾기
     @Transactional(readOnly = true)
     String findEmailByNameAndPhoneNumber(String name, String phoneNumber);
}