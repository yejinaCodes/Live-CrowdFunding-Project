package com.crofle.livecrowdfunding.service;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.hibernate.annotations.NaturalId;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Log4j2
public class EventLogServiceTest {
    @Autowired
    private EventLogService eventLogService;

    @Test
    public void findByUserTest() {
        log.info(eventLogService.findByUser(1L));
    }
}
