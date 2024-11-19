package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.request.ScheduleRegisterRequestDTO;
import com.crofle.livecrowdfunding.service.ScheduleService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/schedule")
@RequiredArgsConstructor
public class ScheduleController {
    private final ScheduleService scheduleService;

    @PostMapping("/create")
    public ResponseEntity<Void> createSchedule(@RequestBody ScheduleRegisterRequestDTO requestDTO) {
        scheduleService.createSchedule(requestDTO);
        return ResponseEntity.ok().build();
    }
}
