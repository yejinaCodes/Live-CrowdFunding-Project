package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.CompositeKey;
import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;

@Entity
public class Liked {
    @EmbeddedId
    private CompositeKey id;

    @ManyToOne
    @JoinColumn(name="foreign_key_1", insertable = false, updatable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name="foreign_key_2", insertable = false, updatable = false)
    private Project project;

    @Column(name="created_at")
    private LocalDateTime createdAt;

}
