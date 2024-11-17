package com.crofle.livecrowdfunding.service;

import java.time.LocalDate;
import java.util.List;

public interface AdminDashBoardService {
    List<String> getLast12Months();
    List<Long> getNewUserStats(LocalDate start, LocalDate end);
    List<Long> getNewMakerStats(LocalDate start, LocalDate end);
    List<Long> getNewTotalStats(LocalDate start, LocalDate end);
}
