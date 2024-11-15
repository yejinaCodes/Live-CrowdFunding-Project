package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;

public interface ProjectService {
    ProjectDetailResponseDTO findProjectDetail(Long id);

    void createProject(ProjectRegisterRequestDTO requestDTO);
}
