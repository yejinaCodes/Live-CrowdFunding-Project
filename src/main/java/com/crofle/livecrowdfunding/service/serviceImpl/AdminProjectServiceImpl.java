package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Image;
import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import com.crofle.livecrowdfunding.dto.*;
import com.crofle.livecrowdfunding.dto.request.ProjectApprovalRequestDTO;
import com.crofle.livecrowdfunding.dto.response.EssentialDocumentDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectResponseInfoDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import com.crofle.livecrowdfunding.service.AdminProjectService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminProjectServiceImpl implements AdminProjectService {
    private final ProjectRepository projectRepository;
    private final ModelMapper modelMapper;

    @Override
    public PageListResponseDTO<ProjectResponseInfoDTO> findProjectList(PageRequestDTO pageRequestDTO) { //naming precision required
        // 1. Create a Pageable object using the pageRequestDTO
        Pageable pageable = PageRequest.of(pageRequestDTO.getPage() - 1, pageRequestDTO.getSize());

        // 2. Fetch a paginated result using the repository
        //반환값을 entity 형태로 저장
        Page<Project> projectPage = projectRepository.findAll(pageable);

        // 3. Map the Project entities to ProjectInfoDTO objects
        //entity 형태를 dto 형태로 response할 수 있는 형태로 변환
        List<ProjectResponseInfoDTO> projectResponseInfoDTOList = projectPage.stream()
                    .map(project -> modelMapper.map(project, ProjectResponseInfoDTO.class))
                    .collect(Collectors.toList());

        // 4. Create PageInfoDTO from pageRequestDTO and the total count of projects
        PageInfoDTO pageInfoDTO = PageInfoDTO.withAll().pageRequestDTO(pageRequestDTO).total((int) projectPage.getTotalElements())
                .build();

        // 5. Return the response wrapped in a PageListResponseDTO
        //여기에서 넣어줘야 하는 pageInfoDTO를 만들기 위해 위에서 build를 해준다.
        PageListResponseDTO<ProjectResponseInfoDTO> pageListResponseDT = PageListResponseDTO.<ProjectResponseInfoDTO>builder()
                .pageInfoDTO(pageInfoDTO)
                .dataList(projectResponseInfoDTOList)
                .build();

        //Service 단에서 체크하는 용
        for (ProjectResponseInfoDTO p : pageListResponseDT.getDataList()) {
            log.info("Project ID: " + p.getId());
            log.info("Product Name: " + p.getProductName());
        }

        return pageListResponseDT;
    }

    @Transactional(readOnly = true) //없애도 잘 동작함..
    @Override
    public ProjectResponseInfoDTO findProject(Long id) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("프로젝트 조회에 실패했습니다"));

        log.info("check1: ", project.getManager().getId());
        ProjectResponseInfoDTO projectResponseInfoDTO = modelMapper.map(project, ProjectResponseInfoDTO.class);
        log.info("checking yejina");
        log.info(projectResponseInfoDTO.getProductName());
        log.info("maker ID: " , projectResponseInfoDTO.getMaker());
        log.info("manager ID: ", projectResponseInfoDTO.getManager());
        return projectResponseInfoDTO;
    }

    @Transactional(readOnly = true)
    @Override
    public List<EssentialDocumentDTO> findEssentialDocs(Long id) {
        Project project = projectRepository.findById(id).orElseThrow(()-> new EntityNotFoundException("해당 프로젝트는 존재하지 않습니다"));

         List<EssentialDocumentDTO> documents = project.getEssentialDocuments().stream()
                .map(doc -> modelMapper.map(doc, EssentialDocumentDTO.class))
                .collect(Collectors.toList());
         if(!project.getImages().isEmpty()) {
             Image firstImage = project.getImages().get(0);
             EssentialDocumentDTO imageDoc = new EssentialDocumentDTO();
             imageDoc.setDocument(firstImage.getImage()); //string 타입의 image가지고 오기
             documents.add(imageDoc);
         }
         return documents;
    }

    @Override
    public void updateApprovalStatus(Long id, ProjectApprovalRequestDTO request) {
        Project project = projectRepository.findById(id).orElseThrow(()-> new EntityNotFoundException("해당 프로젝트는 존재하지 않습니다"));
        project.setReviewProjectStatus(request.getStatus());
        if(request.getStatus() == ProjectStatus.반려){
            project.setRejectionReason(request.getRejectionReason());
        }
        projectRepository.save(project);
    }

    //승인, 반려, 반려 사유 이메일로 보내기



}
