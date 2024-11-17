package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.*;
import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.*;
import com.crofle.livecrowdfunding.repository.*;
import com.crofle.livecrowdfunding.service.ProjectService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {

    private final ProjectRepository projectRepository;
    private final MakerRepository makerRepository;
    private final ManagerRepository managerRepository;
    private final RatePlanRepository ratePlanRepository;
    private final CategoryRepository categoryRepository;
    private final PaymentHistoryRepository paymentHistoryRepository;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public ProjectDetailResponseDTO getProjectForUser(Long id) {
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

    @Transactional(readOnly = true)
    @Override
    public ProjectDetailForMakerResponseDTO getProjectForMaker(Long id) {
// 주문 정보와 함께 프로젝트 로드
        Project project = projectRepository.findByIdWithOrders(id)
                .orElseThrow(() -> new EntityNotFoundException("프로젝트 조회에 실패했습니다"));

        // 이미지와 문서 정보 로드
        Project projectWithImages = projectRepository.findByIdWithImages(id).orElseThrow();
        Project projectWithDocs = projectRepository.findByIdWithDocuments(id).orElseThrow();

        ProjectDetailForMakerResponseDTO projectDetailForMakerResponseDTO = modelMapper.map(project, ProjectDetailForMakerResponseDTO.class);
        projectDetailForMakerResponseDTO.setCategory(project.getCategory().getClassification());
        projectDetailForMakerResponseDTO.setStatus(project.getReviewProjectStatus().name());
        projectDetailForMakerResponseDTO.setPaymentCount((int) project.getOrders().stream()
                .filter(order -> order.getPaymentHistory() != null)
                .count());

        // 이미지와 문서 정보 설정
        projectDetailForMakerResponseDTO.setImages(modelMapper.map(projectWithImages.getImages(),
                new TypeToken<List<ImageResponseDTO>>() {}.getType()));
        projectDetailForMakerResponseDTO.setEssentialDocuments(modelMapper.map(projectWithDocs.getEssentialDocuments(),
                new TypeToken<List<DocumentResponseDTO>>() {}.getType()));

        return projectDetailForMakerResponseDTO;
    }

    @Transactional(readOnly = true)
    @Override
    public ProjectDetailToUpdateResponseDTO getProjectForManagerUpdate(Long id) {

        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("프로젝트 조회에 실패했습니다"));

        ProjectDetailToUpdateResponseDTO projectDetailToUpdateResponseDTO = modelMapper.map(project, ProjectDetailToUpdateResponseDTO.class);
        projectDetailToUpdateResponseDTO.setCategory(project.getCategory().getClassification());
        return projectDetailToUpdateResponseDTO;
    }
}