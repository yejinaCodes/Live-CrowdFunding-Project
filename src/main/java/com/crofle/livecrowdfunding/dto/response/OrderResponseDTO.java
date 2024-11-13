package com.crofle.livecrowdfunding.dto.response;

import com.crofle.livecrowdfunding.domain.entity.PaymentHistory;
import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.entity.User;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class OrderResponseDTO { //주문 정보 응답 DTO
    private Long id;
    private UserInfoResponseDTO user;
    private ProjectDetailResponseDTO project;
    private Integer amount;
    private Integer paymentPrice;
}
