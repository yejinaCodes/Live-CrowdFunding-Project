package com.crofle.livecrowdfunding.service;
import com.crofle.livecrowdfunding.dto.request.ProjectApprovalRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectResponseInfoDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;

public interface AdminProjectService {
    PageListResponseDTO<ProjectResponseInfoDTO> findProjectList(PageRequestDTO pageRequestDTO);
    ProjectResponseInfoDTO findProject(Long id);

    ProjectResponseInfoDTO findEssentialDocs(Long id);

    void updateApprovalStatus(Long id, ProjectApprovalRequestDTO comment);


}
