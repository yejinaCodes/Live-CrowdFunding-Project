package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.entity.Schedule;
import com.crofle.livecrowdfunding.dto.request.ScheduleRegisterRequestDTO;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import com.crofle.livecrowdfunding.repository.ScheduleRepository;
import com.crofle.livecrowdfunding.service.ScheduleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Log4j2
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {
    private final ScheduleRepository scheduleRepository;
    private final ProjectRepository projectRepository;

    @Transactional
    @Override
    public void createSchedule(ScheduleRegisterRequestDTO requestDTO) {
        Schedule schedule = Schedule.builder()
                .project(projectRepository.findById(requestDTO.getProjectId()).orElseThrow())
                .date(requestDTO.getDate())
                .build();
        scheduleRepository.save(schedule);
    }
}
