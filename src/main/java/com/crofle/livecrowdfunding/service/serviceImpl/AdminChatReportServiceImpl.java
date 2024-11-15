package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.ChatReport;
import com.crofle.livecrowdfunding.dto.PageInfoDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ChatReportListDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;
import com.crofle.livecrowdfunding.repository.ChatReportRepository;
import com.crofle.livecrowdfunding.service.AdminChatReportService;
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
    private final ModelMapper modelMapper;

    @Override //신고 list 조회
    public PageListResponseDTO<ChatReportListDTO> findReportList(PageRequestDTO pageRequestDTO) {
        //Pageable로 만들기
        Pageable pageable = PageRequest.of(pageRequestDTO.getPage()-1, pageRequestDTO.getSize());

        //Fetch paginated result using repository
        Page<ChatReport> chatReports = chatReportRepository.findAll(pageable);

        //ChatReport entity랑 ChatReportListDTO랑 매핑하기
        List<ChatReportListDTO> chatReportListDTOList = chatReports.stream()
                .map(chat -> modelMapper.map(chat, ChatReportListDTO.class))
                .collect(Collectors.toList());

        //PageListResponseDTO로 만들어주기
        PageInfoDTO pageInfoDTO = PageInfoDTO.withAll().pageRequestDTO(pageRequestDTO).total((int) chatReports.getTotalElements()).build();

        PageListResponseDTO<ChatReportListDTO> pageListResponseDTO = PageListResponseDTO.<ChatReportListDTO>builder()
                .pageInfoDTO(pageInfoDTO)
                .dataList(chatReportListDTOList)
                .build();

        return pageListResponseDTO;
    }

    //신고 상세 조회
}