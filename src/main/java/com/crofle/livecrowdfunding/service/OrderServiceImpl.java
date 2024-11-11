package com.crofle.livecrowdfunding.service;

import org.springframework.stereotype.Service;

@Service
public class OrderServiceImpl implements OrderService {
    @Override
    public void createOrder() {
        System.out.println("Order created");
    }
}
