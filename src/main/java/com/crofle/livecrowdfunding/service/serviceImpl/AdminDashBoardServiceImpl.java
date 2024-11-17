package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.repository.UserRepository;
import com.crofle.livecrowdfunding.service.AdminDashBoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminDashBoardServiceImpl implements AdminDashBoardService {
    private final UserRepository userRepository;

    @Override
    public List<String> getLast12Months(){
        return Stream.iterate(LocalDate.now().minusMonths(11),
                date->date.plusMonths(1))
                .limit(12)
                .map(date->date.format(DateTimeFormatter.ofPattern("yyyy-MM")))
                .collect(Collectors.toList());
    }
    @Override
    public List<Long>getNewUserStats(LocalDate start, LocalDate end){
        return userRepository.countMonthlyNewUsers(start, end);
    }

    @Override
    public List<Long> getNewMakerStats(LocalDate start, LocalDate end) {
        return userRepository.countMonthlyNewMakers(start,end);
    }

    @Override
    public List<Long> getNewTotalStats(LocalDate start, LocalDate end) {
        return userRepository.countMontlyNewTotal(start, end);
    }

}