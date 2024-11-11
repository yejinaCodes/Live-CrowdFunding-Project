package com.crofle.livecrowdfunding.service;
import com.crofle.livecrowdfunding.dto.ProjectInfoDTO;

import java.util.List;

public interface AdminProjectService {
    List<ProjectInfoDTO> findProjectList();
    ProjectInfoDTO findProject(Long id);

}
