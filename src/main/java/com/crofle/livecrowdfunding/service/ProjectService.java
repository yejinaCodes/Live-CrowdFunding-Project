package com.crofle.livecrowdfunding.service;


import com.crofle.livecrowdfunding.dto.ProjectDetailDTO;

public interface ProjectService {
    ProjectDetailDTO findProjectDetail(Long id);
}
