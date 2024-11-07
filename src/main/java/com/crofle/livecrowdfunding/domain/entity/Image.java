package com.crofle.livecrowdfunding.domain.entity;
import jakarta.persistence.*;
@Entity
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="project_id")
    private Project project;
    private String image;
}
