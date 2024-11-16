package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.enums.DocumentType;
import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import com.crofle.livecrowdfunding.dto.request.DocumentRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ImageRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.EssentialDocumentDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;
import java.util.List;

@SpringBootTest
@Log4j2
public class ProjectServiceTest {
    @Autowired
    private ProjectService projectService;

    @Test
    public void testFindProjectDetail() {
        Long id = 1L;
        ProjectDetailResponseDTO projectDetailResponseDTO = projectService.findProjectDetail(id);
        log.info(projectDetailResponseDTO);
    }

    @Test
    public void testCreateProject() {
         ProjectRegisterRequestDTO requestDTO = ProjectRegisterRequestDTO.builder()
                 .makerId(1L)
                 .planId(2L)
                 .categoryId(1L)
                 .productName("싸디싼 스마트폰")
                 .summary("이건 진짜 싸다")
                 .price(1000000)
                 .discountPercentage(10)
                 .goalAmount(1000000000)
                 .contentImage("contentImage.jpg")
                 .images(List.of(
                         ImageRegisterRequestDTO.builder()
                                 .url("image1.jpg")
                                 .imageNumber(1)
                                 .name("이미지1")
                                 .build(),
                         ImageRegisterRequestDTO.builder()
                                 .url("image2.jpg")
                                 .imageNumber(2)
                                 .name("이미지2")
                                 .build()
                 ))
                 .essentialDocuments(List.of(
                         DocumentRegisterRequestDTO.builder()
                                 .url("document1.pdf")
                                 .docType(DocumentType.개발)
                                 .name("필수문서1")
                                 .build(),
                         DocumentRegisterRequestDTO.builder()
                                 .url("document2.pdf")
                                 .docType(DocumentType.프로젝트)
                                 .name("필수문서2")
                                 .build()
                 ))
                 .build();

         projectService.createProject(requestDTO);
    }

    @Test
    public void testUpdateProjectStatus() {
        Long projectId = 1L;

        ProjectStatusRequestDTO requestDTO = ProjectStatusRequestDTO.builder()
                .status(ProjectStatus.검토중)
                .build();

        projectService.updateProjectStatus(projectId, requestDTO);
    }
}
