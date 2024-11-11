package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.OrderRequestDTO;
import com.crofle.livecrowdfunding.dto.OrderResponseDTO;
import org.springframework.stereotype.Service;

public interface OrderService {
    OrderResponseDTO createOrder(OrderRequestDTO orderRequestDTO);
}
