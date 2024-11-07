package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.EventLogId;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "EVENT_LOG")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class EventLog {
    @EmbeddedId
    private EventLogId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "event_id", nullable = false)
    private Event event;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "winning_prize", nullable = false, length = 255)
    private String winningPrize;

    @Column(name = "winning_data", nullable = false)
    private LocalDateTime winningData;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
}