package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Long> {
//    Page<User> findByConditions(PageRequestDTO pageRequestDTO, Pageable pageable);
    @Query("SELECT u FROM User u " +
            "WHERE (:#{#dto.search?.US} IS NULL OR u.status = :#{T(com.crofle.livecrowdfunding.domain.enums.UserStatus).valueOf(#dto.search.US)}) " +
            "AND (:#{#dto.userName} IS NULL OR u.name LIKE %:#{#dto.userName}%)")
    Page<User> findByConditions(@Param("dto") PageRequestDTO dto, Pageable pageable);

}
