package com.crofle.livecrowdfunding.domain.entity;
import jakarta.persistence.*;

@Entity
public class Orders {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name="user_id", referencedColumnName = "id")
    private User user;

    @ManyToOne
    @JoinColumn(name="project_id")
    private Project projectId;

    private int amount;
    @Column(name="payment_price")
    private int paymentPrice;
}
