package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.entity.Script;
import com.crofle.livecrowdfunding.domain.entity.Video;
import com.crofle.livecrowdfunding.dto.request.ScheduleRegisterRequestDTO;

import java.time.LocalDateTime;

public interface ScheduleService {
    void createSchedule(ScheduleRegisterRequestDTO requestDTO);
}
