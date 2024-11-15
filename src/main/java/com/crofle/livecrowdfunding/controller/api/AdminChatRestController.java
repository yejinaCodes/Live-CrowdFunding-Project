package com.crofle.livecrowdfunding.controller.api;

import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ChatReportListDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;
import com.crofle.livecrowdfunding.service.AdminChatReportService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/api")
public class AdminChatRestController {
    private final AdminChatReportService adminChatReportService;

    //신고 목록 조회
    @GetMapping("/chat-reports")
    public ResponseEntity<PageListResponseDTO<ChatReportListDTO>> getReportList( //조건 조회 없음
        @RequestParam int page) {

        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
                .page(page)
                .build();

        return ResponseEntity.ok(adminChatReportService.findReportList(pageRequestDTO));
    }
}
