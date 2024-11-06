package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

@Entity
public class RatePlan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="plan_name")
    private String planName;
    private Boolean charge;

    @OneToOne(mappedBy="ratePlan")
    private Project project;

}
