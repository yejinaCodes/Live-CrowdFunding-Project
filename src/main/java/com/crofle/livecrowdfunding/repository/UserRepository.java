package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    @Query("SELECT u FROM User u " +
            "WHERE (:#{#dto.search?.US} IS NULL OR u.status = :#{T(com.crofle.livecrowdfunding.domain.enums.UserStatus).valueOf(#dto.search.US)}) " +
            "AND (:#{#dto.userName} IS NULL OR u.name LIKE %:#{#dto.userName}%)")
    Page<User> findByConditions(@Param("dto") PageRequestDTO dto, Pageable pageable);

    @Query(value = """
        SELECT COUNT(u) FROM User u 
        WHERE u.registeredAt >= :startDate AND u.registeredAt < :endDate 
        GROUP BY FUNCTION('DATE_FORMAT', u.registeredAt, '%Y-%m')
        ORDER BY FUNCTION('DATE_FORMAT', u.registeredAt, '%Y-%m')
        """)
    List<Long> countMonthlyNewUsers(
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate
    );

    @Query(value = """
        SELECT COUNT(m) FROM Maker m  
        WHERE m.registeredAt >= :startDate AND m.registeredAt < :endDate 
        GROUP BY FUNCTION('DATE_FORMAT', m.registeredAt, '%Y-%m')
        ORDER BY FUNCTION('DATE_FORMAT', m.registeredAt, '%Y-%m')
        """)

    List<Long> countMonthlyNewMakers(
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate
    );

    // 전체 사용자 통계
    @Query(value = """
        SELECT COUNT(u) 
        FROM User u 
        WHERE u.createdAt >= :startDate 
        AND u.createdAt < :endDate 
        GROUP BY FUNCTION('DATE_FORMAT', u.createdAt, '%Y-%m')
        ORDER BY FUNCTION('DATE_FORMAT', u.createdAt, '%Y-%m')
        """)
    List<Long> countMonthlyTotalUsers(
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate
    );


}