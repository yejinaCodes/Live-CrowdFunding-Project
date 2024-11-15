package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.request.UserStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ChatReportDetailDTO;
import com.crofle.livecrowdfunding.dto.response.ChatReportListDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;

public interface AdminChatReportService {
    PageListResponseDTO<ChatReportListDTO> findReportList(PageRequestDTO pageRequestDTO);

    ChatReportDetailDTO findReportDetail(Long reportId);

    void updateUserStatus(UserStatusRequestDTO updateDTO);

    Long getUserIdByReportId(Long reportId);
}
