package com.crofle.livecrowdfunding.domain;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class EventLogId implements Serializable {
    private Long event;
    private Long user;
}
