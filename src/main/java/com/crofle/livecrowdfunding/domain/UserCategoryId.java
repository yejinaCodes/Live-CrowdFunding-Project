package com.crofle.livecrowdfunding.domain;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class UserCategoryId implements Serializable {
    private Long userId;
    private Long categoryId;
}
