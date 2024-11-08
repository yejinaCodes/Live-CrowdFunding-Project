package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Maker;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MakerRepository extends JpaRepository<Maker, Long> {
}
