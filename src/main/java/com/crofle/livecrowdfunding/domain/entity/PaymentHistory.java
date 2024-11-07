package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.enums.PaymentMethod;
import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class PaymentHistory {
    @Id //외래키 'order_id'를 기본키로 사용
    private Long orderId;

    @OneToOne //Orders 쪽에는 세팅 필요없음.
    @JoinColumn(name = "order_id", insertable = false, updatable = false)
    private Orders orders;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method")
    private PaymentMethod paymentMethod;

    @Column(name = "delivery_address")
    private String deliveryAddress;

    @Column(name = "payment_at")
    private LocalDateTime paymentAt;

    @Column(name = "refund_status")
    private Boolean refundStatus;

}
