package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Table(name = "CATEGORY")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class Category {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long id;

    @Column(length = 30, nullable = false)
    private String classification;

    @OneToMany(mappedBy = "category")
    private List<Project> projects = new ArrayList<>();

    @OneToMany(mappedBy = "category")
    private List<UserInterest> userInterests = new ArrayList<>();
}