package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailToUpdateResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailForMakerResponseDTO;

public interface ProjectService {
    ProjectDetailResponseDTO getProjectForUser(Long id);

    void createProject(ProjectRegisterRequestDTO requestDTO);

    void updateProjectStatus(Long id, ProjectStatusRequestDTO requestDTO);
    
    ProjectDetailForMakerResponseDTO getProjectForMaker(Long id);

    ProjectDetailToUpdateResponseDTO getProjectForManagerUpdate(Long id);
}
