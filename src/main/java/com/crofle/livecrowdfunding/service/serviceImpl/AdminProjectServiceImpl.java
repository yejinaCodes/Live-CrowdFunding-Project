package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.dto.ProjectInfoDTO;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import com.crofle.livecrowdfunding.service.AdminProjectService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminProjectServiceImpl implements AdminProjectService {
    private final ProjectRepository projectRepository;
    private final ModelMapper modelMapper;

    @Override
    public List<ProjectInfoDTO> findProjectList() {
        List<Project> projectList = projectRepository.findAll();
        List<ProjectInfoDTO> projectInfoDTOList = modelMapper.map(projectList, ProjectInfoDTO.class);

        return projectInfoDTOList;
    }

    @Override
    public ProjectInfoDTO findProject(Long id) {
        Optional<Project> project = projectRepository.findById(id);
        ProjectInfoDTO projectInfoDTO = modelMapper.map(project, ProjectInfoDTO.class);
        log.info("checking yejina");
        log.info(projectInfoDTO.getProductName());

        return projectInfoDTO;
    }

    //승인, 반려, 반려 사유 이메일로 보내기
}
