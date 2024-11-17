package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProjectRepository extends JpaRepository<Project, Long> {
    @Query("SELECT DISTINCT p FROM Project p " +
            "LEFT JOIN FETCH p.orders o " +
            "LEFT JOIN FETCH o.paymentHistory " +
            "LEFT JOIN FETCH p.category " +
            "WHERE p.id = :id")
    Optional<Project> findByIdWithOrders(@Param("id") Long id);

    @Query("SELECT DISTINCT p FROM Project p " +
            "LEFT JOIN FETCH p.images " +
            "WHERE p.id = :id")
    Optional<Project> findByIdWithImages(@Param("id") Long id);

    @Query("SELECT DISTINCT p FROM Project p " +
            "LEFT JOIN FETCH p.essentialDocuments " +
            "WHERE p.id = :id")
    Optional<Project> findByIdWithDocuments(@Param("id") Long id);

    @Query("SELECT p FROM Project p WHERE p.reviewProjectStatus IN :statuses")
    List<Project> findByReviewStatuses(@Param("statuses") List<ProjectStatus> statuses);

    // 펀딩 진행 중인 프로젝트 조회 (승인 && 펀딩중)
    @Query("SELECT p FROM Project p WHERE p.reviewProjectStatus = :reviewStatus AND p.progressProjectStatus = :progressStatus")
    List<Project> findByReviewStatusAndProgressStatus(
            @Param("reviewStatus") ProjectStatus reviewStatus,
            @Param("progressStatus") ProjectStatus progressStatus
    );

    // 펀딩 종료된 프로젝트 조회 (성공, 미달성)
    @Query("SELECT p FROM Project p WHERE p.progressProjectStatus IN :statuses")
    List<Project> findByProgressStatuses(@Param("statuses") List<ProjectStatus> statuses);
}
