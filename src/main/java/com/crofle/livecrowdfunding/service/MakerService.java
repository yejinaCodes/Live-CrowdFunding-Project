package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.SaveMakerDTO;
import com.crofle.livecrowdfunding.dto.SaveUserDTO;
import com.crofle.livecrowdfunding.dto.request.UserInfoRequestDTO;
import com.crofle.livecrowdfunding.dto.response.UserInfoResponseDTO;

public interface MakerService {


    SaveMakerDTO saveMaker(SaveMakerDTO saveMakerDTO);
}