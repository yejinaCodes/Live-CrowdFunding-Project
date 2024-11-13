package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import com.crofle.livecrowdfunding.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

@RestController
@RequestMapping("/project")
@RequiredArgsConstructor
public class ProjectController {
    private final ProjectService projectService;

    @GetMapping("/{id}")
    public ResponseEntity<ProjectDetailResponseDTO> getProject(@PathVariable Long id) {
        return ResponseEntity.ok(projectService.findProjectDetail(id));
    }
}
