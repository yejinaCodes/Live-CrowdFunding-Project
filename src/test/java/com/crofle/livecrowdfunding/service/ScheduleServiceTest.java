package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.request.ScheduleRegisterRequestDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;

@SpringBootTest
@Log4j2
@RequiredArgsConstructor
public class ScheduleServiceTest {
    @Autowired
    private ScheduleService scheduleService;

    @Test
    public void createScheduleTest() {
        Long projectId = 1L;
        LocalDateTime date = LocalDateTime.now();

        scheduleService.createSchedule(ScheduleRegisterRequestDTO.builder()
                .projectId(projectId)
                .date(date)
                .build());

        log.info("Schedule created");
    }
}
