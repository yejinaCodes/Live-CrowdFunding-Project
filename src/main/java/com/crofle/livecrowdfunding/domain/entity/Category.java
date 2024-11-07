package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Category {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 30, nullable = false)
    private String classification;

    @OneToMany(mappedBy = "interest")
    private List<Project> projects = new ArrayList<>();

    @OneToMany(mappedBy = "category")
    private List<UserInterest> userInterests = new ArrayList<>();
}