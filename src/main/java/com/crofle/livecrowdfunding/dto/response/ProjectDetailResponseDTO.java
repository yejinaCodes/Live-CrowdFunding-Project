package com.crofle.livecrowdfunding.dto.response;

import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectDetailResponseDTO {
    private Long id;
    private ProjectMakerResponseDTO maker;
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
    private List<ImageResponseDTO> images;
    private Integer likeCount;
}
