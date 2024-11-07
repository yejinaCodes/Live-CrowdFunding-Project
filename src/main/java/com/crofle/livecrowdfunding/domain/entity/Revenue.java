package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

@Entity
public class Revenue {
    @Id
    private Long projectId;

    @OneToOne
    @JoinColumn(name = "id", insertable = false, updatable = false)
    private Project project;

    @Column(name = "total_amount")
    private int totalAmount;

}
