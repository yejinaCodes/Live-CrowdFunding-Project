package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.request.OrderRequestDTO;
import com.crofle.livecrowdfunding.dto.response.OrderResponseDTO;
import org.springframework.data.jpa.repository.Query;

public interface OrderService {

    Long createOrder(OrderRequestDTO orderRequestDTO);

    OrderResponseDTO findOrder(Long id);
}
