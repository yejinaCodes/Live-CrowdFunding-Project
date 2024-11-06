package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;

@Entity
public class RatePlan {
    @Id
    private Long id;
    private String plan_name;
    private Boolean charge;

    @OneToOne(mappedBy="ratePlan")
    private Project project;

}
