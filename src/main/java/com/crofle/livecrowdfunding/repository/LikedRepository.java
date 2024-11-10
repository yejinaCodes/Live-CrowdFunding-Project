package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Liked;
import com.crofle.livecrowdfunding.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LikedRepository extends JpaRepository<Liked, Long> {
}
