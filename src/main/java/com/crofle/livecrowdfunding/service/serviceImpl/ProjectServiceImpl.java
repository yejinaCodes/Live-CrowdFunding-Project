package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.*;
import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectMakerResponseDTO;
import com.crofle.livecrowdfunding.repository.*;
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
    private final MakerRepository makerRepository;
    private final ManagerRepository managerRepository;
    private final RatePlanRepository ratePlanRepository;
    private final CategoryRepository categoryRepository;
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

    @Transactional
    @Override
    public void createProject(ProjectRegisterRequestDTO requestDTO) {
        Maker maker = makerRepository.findById(requestDTO.getMakerId())
                .orElseThrow(() -> new EntityNotFoundException("메이커 조회에 실패했습니다"));

        Category category = categoryRepository.findById(requestDTO.getCategoryId())
                .orElseThrow(() -> new EntityNotFoundException("카테고리 조회에 실패했습니다"));

        RatePlan ratePlan = ratePlanRepository.findById(requestDTO.getPlanId())
                .orElseThrow(() -> new EntityNotFoundException("요금제 조회에 실패했습니다"));

        Project project = Project.builder()
                .maker(maker)
                .ratePlan(ratePlan)
                .category(category)
                .productName(requestDTO.getProductName())
                .summary(requestDTO.getSummary())
                .price(requestDTO.getPrice())
                .discountPercentage(requestDTO.getDiscountPercentage())
                .goalAmount(requestDTO.getGoalAmount())
                .contentImage(requestDTO.getContentImage())
                .build();

        if(requestDTO.getImages() != null) {
            requestDTO.getImages().forEach(image -> {
                project.getImages().add(Image.builder()
                        .project(project)
                        .url(image.getUrl())
                        .imageNumber(image.getImageNumber())
                        .name(image.getName())
                        .build());
            });
        }

        if(requestDTO.getEssentialDocuments() != null) {
            requestDTO.getEssentialDocuments().forEach(document -> {
                project.getEssentialDocuments().add(EssentialDocument.builder()
                        .project(project)
                        .name(document.getName())
                        .url(document.getUrl())
                        .docType(document.getDocType())
                        .build());
            });
        }


        projectRepository.save(project);
    }

    @Transactional
    @Override
    public void updateProjectStatus(Long id, ProjectStatusRequestDTO requestDTO) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("프로젝트 조회에 실패했습니다"));

        project.setReviewProjectStatus(requestDTO.getStatus());
    }
}