package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.TopFundingId;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Comment;

import java.time.LocalDateTime;

@Entity
@Getter
@Table(name = "TOP_FUNDING")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class TopFunding {
    @EmbeddedId
    private TopFundingId id;

    @MapsId("projectId") // TopFundingId의 projectId와 매핑
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id", nullable = false)
    private Project project;

    @Column(nullable = false, columnDefinition = "INT UNSIGNED")
    private Integer ranking;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;
}
