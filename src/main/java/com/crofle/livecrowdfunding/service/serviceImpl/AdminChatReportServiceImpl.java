package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.ChatReport;
import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.dto.PageInfoDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.request.UserStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ChatReportDetailDTO;
import com.crofle.livecrowdfunding.dto.response.ChatReportListDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;
import com.crofle.livecrowdfunding.repository.ChatReportRepository;
import com.crofle.livecrowdfunding.repository.UserRepository;
import com.crofle.livecrowdfunding.service.AdminChatReportService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AdminChatReportServiceImpl implements AdminChatReportService {
    private final ChatReportRepository chatReportRepository;
    private final UserRepository userRepository;

//    @Qualifier("ChatmodelMapper")// Bean 이름 지정
//    private final ModelMapper modelMapper;
    private final ModelMapper modelMapper;
    
    @Override //신고 list 조회
    public PageListResponseDTO<ChatReportListDTO> findReportList(PageRequestDTO pageRequestDTO) {
        //Pageable로 만들기
        Pageable pageable = PageRequest.of(pageRequestDTO.getPage()-1, pageRequestDTO.getSize());

        //Fetch paginated result using repository
        Page<ChatReport> chatReports = chatReportRepository.findAll(pageable);

        //ChatReport entity랑 ChatReportListDTO랑 매핑하기
//        List<ChatReportListDTO> chatReportListDTOList = chatReports.stream()
//                .map(chat -> modelMapper.map(chat, ChatReportListDTO.class))
//                .collect(Collectors.toList());

        //project, user의 모든 정보가 필요없을 때:
        List<ChatReportListDTO> chatReportListDTOList = chatReports.stream()
                .map(chat -> ChatReportListDTO.builder()
                        .id(chat.getId())
                        .userId(chat.getUser().getId())
                        .projectId(chat.getProject().getId())
                        .managerId(chat.getManager().getId())
                        .reason(chat.getReason())
                        .chatMessage(chat.getChatMessage())
                        .createdAt(chat.getCreatedAt())
                        .build())
                .collect(Collectors.toList());

        //PageListResponseDTO로 만들어주기
        PageInfoDTO pageInfoDTO = PageInfoDTO.withAll().pageRequestDTO(pageRequestDTO).total((int) chatReports.getTotalElements()).build();

        PageListResponseDTO<ChatReportListDTO> pageListResponseDTO = PageListResponseDTO.<ChatReportListDTO>builder()
                .pageInfoDTO(pageInfoDTO)
                .dataList(chatReportListDTOList)
                .build();

        return pageListResponseDTO;
    }

    @Override
    public ChatReportDetailDTO findReportDetail(Long reportId) {
        ChatReport chatReport = chatReportRepository.findById(reportId)
                .orElseThrow(() -> new EntityNotFoundException("해당 신고 내역이 없습니다"));

        return ChatReportDetailDTO.builder()
                .id(chatReport.getId())
                .userId(chatReport.getUser().getId())
                .userStatus(chatReport.getUser().getStatus())
                .projectId(chatReport.getProject().getId())
                .projectName(chatReport.getProject().getProductName())
                .managerId(chatReport.getManager().getId())
                .reason(chatReport.getReason())
                .chatMessage(chatReport.getChatMessage())
                .createdAt(chatReport.getCreatedAt())
                .build();
    }

    // 사용자 상태 변경
    @Override
    @Transactional
    public void updateUserStatus(UserStatusRequestDTO updateDTO) {
        User user = userRepository.findById(updateDTO.getUserId())
                .orElseThrow(() -> new EntityNotFoundException("해당 사용자가 없습니다."));

        // 2. 신고 내역 삭제 (요청된 경우)
        if (updateDTO.isDeleteReport()) {
            ChatReport chatReport = chatReportRepository.findById(updateDTO.getReportId())
                    .orElseThrow(() -> new EntityNotFoundException("해당 신고 내역이 없습니다"));
            chatReportRepository.delete(chatReport);
            return;
        }

        switch (updateDTO.getStatus()) {
            case 활성화 -> user.activateUser();
            case 비활성화 -> user.deactivateUser();
            case 정지 -> user.suspendUser();
        }
    }
    // reportId를 통해 userId 조회
    public Long getUserIdByReportId(Long reportId) {
        ChatReport chatReport = chatReportRepository.findById(reportId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid reportId: " + reportId));
        return chatReport.getUser().getId();
    }

    //이메일 전송

}