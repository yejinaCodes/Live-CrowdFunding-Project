package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Maker;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MakerRepository extends JpaRepository<Maker, Long> {
//    Page<Maker> findByConditions(PageRequestDTO pageRequestDTO, Pageable pageable);
//}

    //Maker은 상태 조회하지 않음!
@Query("SELECT m FROM Maker m " +
        "WHERE (:#{#dto.userName} IS NULL OR :#{#dto.userName} = '' OR m.name LIKE %:#{#dto.userName}%)")
Page<Maker> findByConditions(@Param("dto") PageRequestDTO dto, Pageable pageable);
}