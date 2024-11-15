package com.crofle.livecrowdfunding.dto.response;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
//관리자쪽 신고현황에서 모달창으로 상세조회하기
public class ChatReportDetailDTO {
    private Long id;
    private ProjectResponseInfoDTO projectId;
    private ProjectResponseInfoDTO projectName;
    private UserMgmResponseDTO userId;
    private UserMgmResponseDTO userStatus;
    private String chatMessage;
    private LocalDateTime createdAt; //신고 날짜
    private ManagerResponseDTO reporterId; //신고 직원ID
    private String reason; //관리자 코멘트


}
