package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectMakerResponseDTO;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import com.crofle.livecrowdfunding.service.ProjectService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Log4j2
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {

    private final ProjectRepository projectRepository;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public ProjectDetailResponseDTO findProjectDetail(Long id) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("프로젝트 조회에 실패했습니다"));

        ProjectDetailResponseDTO projectDetailResponseDTO = modelMapper.map(project, ProjectDetailResponseDTO.class);
        projectDetailResponseDTO.setMaker(modelMapper.map(project.getMaker(), ProjectMakerResponseDTO.class));
        //우선 같이 가져오지만 비동기 처리 고려
        projectDetailResponseDTO.setLikeCount(project.getLikes().size());

        return projectDetailResponseDTO;
    }
}
