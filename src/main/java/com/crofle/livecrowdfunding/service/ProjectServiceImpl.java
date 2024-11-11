package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.dto.ProjectDetailDTO;
import com.crofle.livecrowdfunding.dto.ProjectLikedDTO;
import com.crofle.livecrowdfunding.dto.ProjectMakerDTO;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Log4j2
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {

    private final ProjectRepository projectRepository;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public ProjectDetailDTO findProjectDetail(Long id) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("프로젝트 조회에 실패했습니다"));

        ProjectDetailDTO projectDetailDTO = modelMapper.map(project, ProjectDetailDTO.class);
        projectDetailDTO.setProjectMakerDTO(modelMapper.map(project.getMaker(), ProjectMakerDTO.class));
        //우선 같이 가져오지만 비동기 처리 고려
        projectDetailDTO.setLikeCount(project.getLikes().size());

        return projectDetailDTO;
    }
}
