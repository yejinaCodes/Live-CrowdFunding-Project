package com.crofle.livecrowdfunding.dto;

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
public class OrderResponseDTO {
    private Long id;
    //dto로 바꾸자
    private User user;
    private Project project;
    private Integer amount;
    private Integer paymentPrice;
}
