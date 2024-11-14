package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.response.UserEventLogResponseDTO;

import java.util.List;

public interface EventLogService {
    List<UserEventLogResponseDTO> findByUser(Long userId);
}
