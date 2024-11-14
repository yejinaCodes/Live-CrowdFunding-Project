package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.response.UserEventLogResponseDTO;
import com.crofle.livecrowdfunding.service.EventLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/event-log")
public class EventLogController {
    private final EventLogService eventLogService;

    @GetMapping("/{userId}")
    public ResponseEntity<List<UserEventLogResponseDTO>> findByUser(@PathVariable Long userId) {
        return ResponseEntity.ok().body(eventLogService.findByUser(userId));
    }
}
