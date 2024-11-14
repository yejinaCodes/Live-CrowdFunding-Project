package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.request.OrderRequestDTO;
import com.crofle.livecrowdfunding.dto.response.OrderHistoryResponseDTO;
import com.crofle.livecrowdfunding.dto.response.OrderResponseDTO;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderService {

    OrderResponseDTO createOrder(OrderRequestDTO orderRequestDTO);

    OrderResponseDTO findOrder(Long id);

    List<OrderHistoryResponseDTO> findByUser(Long userId);
}
