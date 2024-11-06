package com.crofle.livecrowdfunding.domain;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class CompositeKey implements Serializable {
    private Long foreignKey1;
    private Long getForeignKey2;
}
