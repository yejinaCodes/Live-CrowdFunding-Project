package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.enums.UserStatus;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Comment;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "USERS")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 30, nullable = false)
    private String name;

    @Column(length = 30)
    private String nickname;

    @Column(length = 30, nullable = false)
    private String phone;

    @Column(nullable = false)
    private Boolean gender;

    @Column(length = 10, nullable = false)
    private String birth;

    @Column(length = 20, nullable = false, unique = true)
    private String email;

    @Column(length = 50, nullable = false)
    private String password;

    @Column(nullable = false)
    private Integer zipcode;

    @Column(length = 50, nullable = false)
    private String address;

    @Column(name = "detail_address", length = 50, nullable = false)
    private String detailAddress;

    @Builder.Default
    @Column(name = "login_method", nullable = false)
    private Boolean loginMethod = false;

    @Column(name = "registered_at", nullable = false, updatable = false)
    private LocalDateTime registeredAt;

    @Column(name = "unregistered_at")
    private LocalDateTime unregisteredAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserStatus status;

    @Builder.Default
    @Column(nullable = false)
    private Boolean notification = false;

    @Builder.Default
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<UserInterest> interests = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "user")
    private List<Liked> likes = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "user")
    private List<Orders> orders = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    @Builder.Default
    private List<ChatReport> chatReports = new ArrayList<>();

}
