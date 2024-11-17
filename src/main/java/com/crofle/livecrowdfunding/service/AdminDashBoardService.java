package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.response.MonthlyUserCountResponseDTO;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface AdminDashBoardService {
    List<String> getLast12Months();
    List<MonthlyUserCountResponseDTO> getNewUserStats(LocalDateTime start, LocalDateTime end);
    List<MonthlyUserCountResponseDTO> getNewMakerStats(LocalDateTime start, LocalDateTime end);
    List<MonthlyUserCountResponseDTO> getNewTotalStats(LocalDateTime start, LocalDateTime end);
}
