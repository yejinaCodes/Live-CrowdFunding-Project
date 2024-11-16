package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;

public interface ProjectService {
    ProjectDetailResponseDTO findProjectDetail(Long id);

    void createProject(ProjectRegisterRequestDTO requestDTO);

    void updateProjectStatus(Long id, ProjectStatusRequestDTO requestDTO);
}
