package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.dto.projection.EventLogWithEventNameDTO;
import com.crofle.livecrowdfunding.dto.response.UserEventLogResponseDTO;
import com.crofle.livecrowdfunding.repository.EventLogRepository;
import com.crofle.livecrowdfunding.service.EventLogService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class EventLogServiceImpl implements EventLogService {
    private final EventLogRepository eventLogRepository;

    @Override
    public List<UserEventLogResponseDTO> findByUser(Long userId) {
        List<EventLogWithEventNameDTO> eventLogWithEventNameDTOS = eventLogRepository.findByUser(userId);

        return eventLogWithEventNameDTOS.stream()
                .map(eventLogWithEventNameDTO -> UserEventLogResponseDTO.builder()
                        .eventName(eventLogWithEventNameDTO.getEventName())
                        .createdAt(eventLogWithEventNameDTO.getEventLog().getCreatedAt().toString())
                        .winningDate(eventLogWithEventNameDTO.getEventLog().getWinningData().toString())
                        .winningPrize(eventLogWithEventNameDTO.getEventLog().getWinningPrize())
                        .build())
                .toList();
    }
}
