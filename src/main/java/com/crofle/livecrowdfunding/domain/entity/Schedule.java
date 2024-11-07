package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class Schedule {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;
    private LocalDateTime date;
}
