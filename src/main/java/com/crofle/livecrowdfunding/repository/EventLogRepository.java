package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.EventLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventLogRepository extends JpaRepository<EventLog, Long> {
}
