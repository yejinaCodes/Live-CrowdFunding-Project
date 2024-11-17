package com.crofle.livecrowdfunding.repository;
import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.MonthlyUserCountResponseDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    @Query("SELECT u FROM User u " +
            "WHERE (:#{#dto.search?.US} IS NULL OR u.status = :#{T(com.crofle.livecrowdfunding.domain.enums.UserStatus).valueOf(#dto.search.US)}) " +
            "AND (:#{#dto.userName} IS NULL OR u.name LIKE %:#{#dto.userName}%)")
    Page<User> findByConditions(@Param("dto") PageRequestDTO dto, Pageable pageable);

    //가입 현황 그래프 용
    //Users
    @Query(value = """
    SELECT DATE_FORMAT(registered_at, '%Y-%m') as month, COUNT(*) as count
    FROM Users WHERE registered_at >= :startDate AND registered_at < :endDate 
    GROUP BY DATE_FORMAT(registered_at, '%Y-%m') ORDER BY month """, nativeQuery = true)
    List<Object[]> countMonthlyNewUsers(@Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);

    //Maker
    @Query(value = """
    SELECT DATE_FORMAT(registered_at, '%Y-%m') as month, COUNT(*) as count
    FROM Maker WHERE registered_at >= :startDate AND registered_at < :endDate 
    GROUP BY DATE_FORMAT(registered_at, '%Y-%m') ORDER BY month """, nativeQuery = true)
    List<Object[]> countMonthlyNewMakers( @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);

    // 전체 사용자 통계 Native query 사용
    @Query(value = """
   SELECT DATE_FORMAT(combined.registered_at, '%Y-%m') as month, COUNT(*) as count
   FROM (SELECT registered_at FROM Users WHERE registered_at >= :startDate AND registered_at < :endDate
       UNION ALL SELECT registered_at FROM Maker WHERE registered_at >= :startDate AND registered_at < :endDate
   ) combined
   GROUP BY DATE_FORMAT(combined.registered_at, '%Y-%m') ORDER BY month """, nativeQuery = true)
    List<Object[]> countMonthlyNewTotal(
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate
    );

    //이용자 현황 그래프 용
    //Users
    @Query(value = """
    SELECT DATE_FORMAT(registered_at, '%Y-%m') as month, COUNT(*) as count
    FROM Users WHERE registered_at >= :startDate AND registered_at < :endDate 
    GROUP BY DATE_FORMAT(registered_at, '%Y-%m') ORDER BY month """, nativeQuery = true)
    List<Object[]> countMonthlyCurrentUsers( @Param("startDate") LocalDateTime startDate,
                                          @Param("endDate") LocalDateTime endDate);

    //Maker
    @Query(value = """
    SELECT DATE_FORMAT(registered_at, '%Y-%m') as month, COUNT(*) as count
    FROM Maker WHERE registered_at >= :startDate AND registered_at < :endDate 
    GROUP BY DATE_FORMAT(registered_at, '%Y-%m') ORDER BY month """, nativeQuery = true)
    List<Object[]> countMonthlyCurrentMakers( @Param("startDate") LocalDateTime startDate,
                                          @Param("endDate") LocalDateTime endDate);

    //Total
    @Query(value = """
   SELECT DATE_FORMAT(combined.registered_at, '%Y-%m') as month, COUNT(*) as count
   FROM (SELECT registered_at FROM Users WHERE registered_at >= :startDate AND registered_at < :endDate
       UNION ALL SELECT registered_at FROM Maker WHERE registered_at >= :startDate AND registered_at < :endDate
   ) combined
   GROUP BY DATE_FORMAT(combined.registered_at, '%Y-%m') ORDER BY month """, nativeQuery = true)
    List<Object[]> countMonthlyCurrentTotal(
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate
    );

}