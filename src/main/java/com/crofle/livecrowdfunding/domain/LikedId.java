package com.crofle.livecrowdfunding.domain;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class LikedId implements Serializable {
    private Long userId;
    private Long projectId;
}
