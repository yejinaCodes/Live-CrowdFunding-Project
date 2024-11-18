package com.crofle.livecrowdfunding.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CategoryStatsResponseDTO {
    private String month;
    private String category;
    private Long successCount;
    private Double revenue;
}
