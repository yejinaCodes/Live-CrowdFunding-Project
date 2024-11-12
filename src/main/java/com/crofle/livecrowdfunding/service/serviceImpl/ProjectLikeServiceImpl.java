package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Liked;
import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.domain.id.LikedId;
import com.crofle.livecrowdfunding.repository.LikedRepository;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import com.crofle.livecrowdfunding.repository.UserRepository;
import com.crofle.livecrowdfunding.service.ProjectLikeService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@Log4j2
@RequiredArgsConstructor
public class ProjectLikeServiceImpl implements ProjectLikeService {
    private final LikedRepository likedRepository;
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;

    @Transactional
    public void toggleLike(Long projectId, Long userId) {
        // 복합키 생성
        LikedId likedId = new LikedId(userId, projectId);

        // 이미 찜한 상태인지 확인
        boolean isAlreadyLiked = likedRepository.existsById(likedId);

        if (isAlreadyLiked) {
            // 찜 해제
            likedRepository.deleteById(likedId);
            log.info("프로젝트 찜 해제 - projectId: {}, userId: {}", projectId, userId);
        } else {
            // 찜 등록
            Project project = projectRepository.findById(projectId)
                    .orElseThrow(() -> new EntityNotFoundException("프로젝트를 찾을 수 없습니다."));

            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new EntityNotFoundException("사용자를 찾을 수 없습니다."));

            Liked liked = Liked.builder()
                    .id(likedId)
                    .project(project)
                    .user(user)
                    .createdAt(LocalDateTime.now())
                    .build();

            likedRepository.save(liked);
            log.info("프로젝트 찜 등록 - projectId: {}, userId: {}", projectId, userId);
        }
    }

    @Override
    public boolean isAlreadyLiked(LikedId likedId) {
        return likedRepository.existsById(likedId);
    }
}
