package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;

@Entity
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String nickname;
    private String phone;
    private Boolean gender;
    private String birth;
    private String email;
    private String password;
    private Integer zipcode;
    private String address;
    @Column(name = "detail_address")
    private String detailAddress;
    @Column(name = "login_method")
    private Boolean loginMethod;
    @Column(name = "registered_at")
    private LocalDateTime registeredAt;
    @Column(name = "unregistered_at")
    private LocalDateTime unregisteredAt;
    @Enumerated(EnumType.STRING)
    private Enum status;
    private Boolean notification;
}
