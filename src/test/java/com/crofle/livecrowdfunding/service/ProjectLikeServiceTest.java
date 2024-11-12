package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.id.LikedId;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Log4j2
public class ProjectLikeServiceTest {
    @Autowired
    private ProjectLikeService projectLikeService;

    @Test
    public void testToggleLike() {
        Long projectId = 1L;
        Long userId = 1L;
        projectLikeService.toggleLike(projectId, userId);
    }

    @Test
    public void testIsAlreadyLiked() {
        Long projectId = 1L;
        Long userId = 1L;
        LikedId likedId = new LikedId(userId, projectId);
        boolean isAlreadyLiked = projectLikeService.isAlreadyLiked(likedId);

        if (isAlreadyLiked) {
            log.info("이미 찜한 상태입니다.");
        } else {
            log.info("찜하지 않은 상태입니다.");
        }
    }
}
