package com.crofle.livecrowdfunding.domain.id;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class LikedId implements Serializable {
    private Long userId;
    private Long projectId;
}
