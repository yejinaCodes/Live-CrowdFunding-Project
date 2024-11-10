package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ProjectServiceImpl {

    private final ProjectRepository projectRepository;

    @Autowired
    public ProjectServiceImpl(ProjectRepository projectRepository) {
        this.projectRepository = projectRepository;
    }

    public void findProjectDetail(Long id) {
        Optional<Project> project = Optional.of(projectRepository.findById(id).get());


    }

}
