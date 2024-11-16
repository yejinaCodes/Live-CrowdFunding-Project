package com.crofle.livecrowdfunding.service.serviceImpl;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@Log4j2
public class AdminDashBoardServiceImpl {

    public List<String> getLast12Months(){
        return Stream.iterate(LocalDate.now().minusMonths(11),
                date->date.plusMonths(1))
                .limit(12)
                .map(date->date.format(DateTimeFormatter.ofPattern("yyyy-MM")))
                .collect(Collectors.toList());
    }

}