package com.crofle.livecrowdfunding.dto;

import lombok.*;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SearchTypeDTO {
    private String RS;   // 검토 상태 review status
    private String PS;   // 진행 상태 progress status
    private String SD;  // start date
    private String ED;  // end date

}
