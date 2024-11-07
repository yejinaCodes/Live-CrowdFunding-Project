package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.CompositeKey;
import com.crofle.livecrowdfunding.domain.UserCategoryId;
import jakarta.persistence.*;

@Entity
public class UserInterest {
    @EmbeddedId
    private UserCategoryId id;
    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name="user_id", insertable = false, updatable = false)
    private User user;
    @ManyToOne
    @MapsId("categoryId")
    @JoinColumn(name="category_id", insertable = false, updatable = false)
    private Category category;
}
