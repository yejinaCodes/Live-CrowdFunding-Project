package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.UserInfoDTO;

public interface UserService {

     UserInfoDTO findUser(Long userId);

     void updateUser(UserInfoDTO userInfoDTO);

     void deleteUser(Long userId);
}