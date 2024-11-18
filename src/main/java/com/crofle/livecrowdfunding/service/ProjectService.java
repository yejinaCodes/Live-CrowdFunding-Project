package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;

public interface ProjectService {
    ProjectDetailResponseDTO findProjectDetail(Long id);



}
