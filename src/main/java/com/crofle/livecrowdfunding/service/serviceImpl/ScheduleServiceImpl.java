package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.entity.Schedule;
import com.crofle.livecrowdfunding.dto.request.ScheduleRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ScheduleReserveResponseDTO;
import com.crofle.livecrowdfunding.dto.response.TimeSlotResponseDTO;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import com.crofle.livecrowdfunding.repository.ScheduleRepository;
import com.crofle.livecrowdfunding.service.ScheduleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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

    @Transactional(readOnly = true)
    @Override
    public List<ScheduleReserveResponseDTO> getReserveSchedule(LocalDateTime startDate) {

        LocalDateTime endDate = startDate.plusDays(3);

        // DB에서 해당 기간의 예약된 스케줄 조회
        List<Schedule> existingSchedules = scheduleRepository.findByDateBetween(startDate, endDate);

        List<ScheduleReserveResponseDTO> availableSlots = new ArrayList<>();
        LocalDateTime current = startDate;

        // 7일간의 각 날짜별로 순회
        while (!current.isAfter(endDate)) {
            List<TimeSlotResponseDTO> dailySlots = new ArrayList<>();

            // 12시부터 23시까지 순회
            for (int hour = 12; hour <= 23; hour++) {
                LocalDateTime timeSlot = current.withHour(hour).withMinute(0).withSecond(0);

                // 해당 시간대의 예약된 방송 수 계산
                long bookedCount = existingSchedules.stream()
                        .filter(schedule -> schedule.getDate().equals(timeSlot))
                        .count();

                // 최대 3개까지 예약 가능하므로, 남은 슬롯 수 계산
                int availableCount = 3 - (int) bookedCount;

                dailySlots.add(new TimeSlotResponseDTO(
                        timeSlot,
                        availableCount > 0,
                        availableCount
                ));
            }

            availableSlots.add(new ScheduleReserveResponseDTO(
                    current.toLocalDate(),
                    dailySlots
            ));

            current = current.plusDays(1);
        }

        return availableSlots;
    }
}
