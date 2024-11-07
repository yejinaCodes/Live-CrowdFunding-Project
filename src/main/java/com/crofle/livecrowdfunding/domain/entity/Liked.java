package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.CompositeKey;
import com.crofle.livecrowdfunding.domain.LikedId;
import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;

@Entity
public class Liked {
    @EmbeddedId
    private LikedId id;

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name="user_id", insertable = false, updatable = false)
    private User user;

    @ManyToOne
    @MapsId("projectId")
    @JoinColumn(name="project_id", insertable = false, updatable = false)
    private Project project;

    @Column(name="created_at")
    private LocalDateTime createdAt;

}
