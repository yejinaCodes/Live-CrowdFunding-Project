package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class Maker {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String phone;
    private Long business;
    private String email;
    private String password;
    private Integer zipcode;
    private String address;
    @Column(name = "detail_address")
    private String detailAddress;
    @Column(name = "register_status")
    private Boolean registerStatus;
    @Column(name = "unregistered_at")
    private LocalDateTime unregisteredAt;
    @Column(name = "registered_at")
    private LocalDateTime registeredAt;
    private Boolean status;
}
