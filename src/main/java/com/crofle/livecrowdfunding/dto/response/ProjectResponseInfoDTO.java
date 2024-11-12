package com.crofle.livecrowdfunding.dto.response;

import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import lombok.*;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProjectResponseInfoDTO {
    private Long id;
    private Long makerId;
    private Long managerId;
    private Long ratePlanId;

    private Long categoryId;
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

}
