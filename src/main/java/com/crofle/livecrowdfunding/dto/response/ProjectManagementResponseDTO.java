package com.crofle.livecrowdfunding.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProjectManagementResponseDTO { // 판매자 프로젝트 조회, 프로젝트 정보와 미니 대시보드 리턴
    private ProjectDetailResponseDTO projectDetail;
}
