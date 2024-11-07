package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class ChatReport {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;
    @ManyToOne
    @JoinColumn(name = "manager_id")
    private Manager manager;
    private String reason;
    @Column(name = "chat_message")
    private String chatMessage;
    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
