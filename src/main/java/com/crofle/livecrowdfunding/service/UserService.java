package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.request.UserInfoRequestDTO;
import com.crofle.livecrowdfunding.dto.response.UserInfoResponseDTO;

public interface UserService {

     UserInfoResponseDTO findUser(Long userId);

     void updateUser(Long id, UserInfoRequestDTO userInfoRequestDTO);

     void deleteUser(Long userId);
}