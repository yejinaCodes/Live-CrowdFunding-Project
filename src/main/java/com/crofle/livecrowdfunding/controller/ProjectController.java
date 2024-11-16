package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.request.ProjectRegisterRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectStatusRequestDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectDetailResponseDTO;
import com.crofle.livecrowdfunding.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

@RestController
@RequestMapping("/api/project")
@RequiredArgsConstructor
public class ProjectController {
    private final ProjectService projectService;

    @GetMapping("/{id}")
    public ResponseEntity<ProjectDetailResponseDTO> getProject(@PathVariable Long id) {
        return ResponseEntity.ok(projectService.findProjectDetail(id));
    }

    @PostMapping
    public ResponseEntity<Void> createProject(@RequestBody ProjectRegisterRequestDTO requestDTO) {
        projectService.createProject(requestDTO);
        return ResponseEntity.ok().build();
    }

    @PatchMapping("{id}/status/")
    public ResponseEntity<Void> updateProjectStatus(@PathVariable Long id, @RequestBody ProjectStatusRequestDTO requestDTO) {
        projectService.updateProjectStatus(id, requestDTO);
        return ResponseEntity.ok().build();
    }
}
