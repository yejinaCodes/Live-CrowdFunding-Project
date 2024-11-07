package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

@Entity
public class Script {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne
    private Schedule schedule;
    @Column(name = "script_url")
    private String scriptUrl;
}
