package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

@Entity
public class Video {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne
    @JoinColumn(name = "schedule_id", insertable = false, updatable = false)
    private Schedule schedule;
    @Column(name = "media_url")
    private String mediaUrl;
}
