package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrdersRepository extends JpaRepository<Orders, Long> {
}
