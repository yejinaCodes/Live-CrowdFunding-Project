package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.LikedId;
import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;

@Entity
public class Liked {
    @EmbeddedId
    private LikedId id;

    @ManyToOne
    @MapsId("userId") //복합키에서 특정 필드를 다른 엔티티의 외래 키로 사용하는데 사용
    @JoinColumn(name="user_id", insertable = false, updatable = false) //복합 키의 특정 필드를 외래키로 사용하는 엔티티 간 관계를 매핑
    private User user;

    @ManyToOne
    @MapsId("projectId")
    @JoinColumn(name="project_id", insertable = false, updatable = false)
    private Project project;

    @Column(name="created_at")
    private LocalDateTime createdAt;

}
