package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

@Entity
public class Manager {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    @Column(name = "identification_number")
    private String identificationNumber;
    private String email;
    private String phone;
    private String password;
    @Column(name = "registered_at")
    private String registeredAt;
}
