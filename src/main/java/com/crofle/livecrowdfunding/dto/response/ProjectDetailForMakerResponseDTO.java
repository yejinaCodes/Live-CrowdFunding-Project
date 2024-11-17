package com.crofle.livecrowdfunding.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProjectDetailForMakerResponseDTO { // 판매자 프로젝트 조회, 프로젝트 정보와 미니 대시보드 리턴
    private String productName;
    private Integer price;
    private String category;
    private String status;
    private Integer discountPercentage;
    private LocalDateTime startAt;
    private LocalDateTime endAt;
    private Integer percentage;
    private Integer goalAmount;
    private List<ImageResponseDTO> images;

}
