package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.id.LikedId;
import com.crofle.livecrowdfunding.dto.request.LikedRequestDTO;


public interface LikedService {
    boolean toggleLike(LikedRequestDTO likedRequestDTO);
}
