package com.crofle.livecrowdfunding.dto.response;

import com.crofle.livecrowdfunding.domain.entity.PaymentHistory;
import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.entity.User;
import jakarta.persistence.*;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderResponseDTO { //주문 정보 리턴
    private Long id;
    private OrderUserResponse user;
    private OrderProjectResponseDTO project;
    private Integer amount;
    private Integer paymentPrice;
}
