package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.request.OrderRequestDTO;
import com.crofle.livecrowdfunding.dto.response.OrderResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import com.crofle.livecrowdfunding.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/order")
@Log4j2
public class OrderController {
    private final OrderService orderService;


    @PostMapping
    public ResponseEntity<Long> createOrder(@RequestBody OrderRequestDTO orderRequestDTO) {
        Long id = orderService.createOrder(orderRequestDTO);
        return ResponseEntity.created(URI.create("/order/" + id)).body(id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDTO> getOrder(@PathVariable Long id) {
        return ResponseEntity.ok(orderService.findOrder(id));
    }
}
