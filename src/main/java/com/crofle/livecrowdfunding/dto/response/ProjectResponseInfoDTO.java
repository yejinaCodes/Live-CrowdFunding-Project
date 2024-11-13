package com.crofle.livecrowdfunding.dto.response;

import com.crofle.livecrowdfunding.domain.entity.*;
import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
//관리자측 프로젝트 관리 > 프로젝트 리스트 조회
public class ProjectResponseInfoDTO {
    private Long id;
    private ProjectMakerResponseDTO maker; //MakerResponseDTO로 바꿔야 한다. 그래야 매핑
    private ManagerResponseDTO manager; //ManagerResponseDTO로 만들어야 한다.
    private RatePlanResponseDTO ratePlan; //RatePlanResponseDTO

    private CategoryResponseDTO category;
    private String productName;
    private String summary;
    private Integer price;
    private Integer discountPercentage;
    private LocalDateTime startAt;
    private LocalDateTime endAt;
    private Integer percentage;
    private ProjectStatus reviewProjectStatus;
    private String rejectionReason;
    private ProjectStatus progressProjectStatus;
    private Integer goalAmount;
    private String contentImage;

    //승인, 반려를 위해 확인해야하는 docs
    private List<EssentialDocumentDTO> documents;
    private List<Image> images;

}
