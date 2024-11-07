package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Comment;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Maker {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 20, nullable = false)
    private String name;

    @Column(length = 20, nullable = false)
    private String phone;

    @Column(nullable = false)
    private Integer business;

    @Column(length = 30, nullable = false)
    private String email;

    @Column(length = 20, nullable = false)
    private String password;

    @Column(nullable = false)
    private Integer zipcode;

    @Column(length = 30, nullable = false)
    private String address;

    @Column(name = "detail_address", length = 50, nullable = false)
    private String detailAddress;

    @Column(name = "register_status", nullable = false)
    private Integer registerStatus;

    @Column(name = "unregistered_at")
    private LocalDateTime unregisteredAt;

    @Column(name = "registered_at", nullable = false, updatable = false)
    private LocalDateTime registeredAt;

    @Column(nullable = false)
    @Comment("0: 활성, 1: 탈퇴")
    private Integer status = 0;

    @OneToMany(mappedBy = "maker")
    private List<Project> projects = new ArrayList<>();
}
