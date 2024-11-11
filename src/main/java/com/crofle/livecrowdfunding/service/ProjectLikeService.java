package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.id.LikedId;


public interface ProjectLikeService {
    void toggleLike(Long projectId, Long userId);

    boolean isAlreadyLiked(LikedId likedId);
}
