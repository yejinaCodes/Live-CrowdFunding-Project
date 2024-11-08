package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Table(name = "RATE_PLAN")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class RatePlan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "plan_name", length = 20, nullable = false)
    private String planName;

    @Column(nullable = false)
    private Short charge;

    @OneToMany(mappedBy = "ratePlan")
    private List<Project> projects = new ArrayList<>();
}
