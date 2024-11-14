package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Maker;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MakerRepository extends JpaRepository<Maker, Long> {
    Page<Maker> findByConditions(PageRequestDTO pageRequestDTO, Pageable pageable);
}