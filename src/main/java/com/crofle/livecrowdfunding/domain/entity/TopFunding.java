package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class TopFunding {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="project_id")
    private Project projectId;

    private int ranking;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

}
