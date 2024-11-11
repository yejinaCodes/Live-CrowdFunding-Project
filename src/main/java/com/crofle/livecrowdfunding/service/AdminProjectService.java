package com.crofle.livecrowdfunding.service;
import com.crofle.livecrowdfunding.dto.ProjectInfoDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;

import java.util.List;

public interface AdminProjectService {
    PageListResponseDTO<ProjectInfoDTO> findProjectList(PageRequestDTO pageRequestDTO);
    ProjectInfoDTO findProject(Long id);

}
