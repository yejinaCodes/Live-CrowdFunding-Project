package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.ProjectLikedResponseDTO;
import com.crofle.livecrowdfunding.dto.request.LikedRequestDTO;

import java.util.List;


public interface LikedService {
    boolean toggleLike(LikedRequestDTO likedRequestDTO);

    List<ProjectLikedResponseDTO> getUserLikedProjects(Long userId);
}
