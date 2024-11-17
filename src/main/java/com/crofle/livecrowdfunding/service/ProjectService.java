package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.request.ProjectListRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectUpdateRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailToUpdateResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailForMakerResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectListResponseDTO;

import java.util.List;

public interface ProjectService {
    ProjectDetailResponseDTO getProjectForUser(Long id);

    void createProject(ProjectRegisterRequestDTO requestDTO);

    void updateProjectStatus(Long id, ProjectStatusRequestDTO requestDTO);
    
    ProjectDetailForMakerResponseDTO getProjectForMaker(Long id);

    ProjectDetailToUpdateResponseDTO getProjectForManagerUpdate(Long id);

    void updateProject(Long id, ProjectUpdateRequestDTO requestDTO);

    List<ProjectListResponseDTO> getProjectList(ProjectListRequestDTO requestDTO);
}
