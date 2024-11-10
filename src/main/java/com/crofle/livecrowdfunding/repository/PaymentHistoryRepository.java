package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.PaymentHistory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentHistoryRepository extends JpaRepository<PaymentHistory, Long> {
}
