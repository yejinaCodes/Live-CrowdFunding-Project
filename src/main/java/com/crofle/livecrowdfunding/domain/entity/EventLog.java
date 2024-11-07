package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class EventLog {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "event_id")
    private Event event;
    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @Column(name = "winning_prize")
    private String winningPrize;
    @Column(name = "winning_data")
    private LocalDateTime winningData;
    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
