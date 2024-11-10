package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Project;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectRepository extends JpaRepository<Project, Long> {
}
