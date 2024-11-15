package com.crofle.livecrowdfunding.dto.response;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
//관리자 신고 현황 조회 시 ChatReportList 보여주기
public class ChatReportListDTO {
    private Long id;
    private ProjectResponseInfoDTO projectId;
    private UserInfoResponseDTO userId;
    private String chatMessage;
    private LocalDateTime reportDate;
}
