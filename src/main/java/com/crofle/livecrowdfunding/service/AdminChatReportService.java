package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ChatReportListDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;

public interface AdminChatReportService {
    PageListResponseDTO<ChatReportListDTO> findReportList(PageRequestDTO pageRequestDTO);
}
