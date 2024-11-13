package com.crofle.livecrowdfunding.controller.api;

import com.crofle.livecrowdfunding.dto.SearchTypeDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectResponseInfoDTO;
import com.crofle.livecrowdfunding.service.AdminProjectService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/api")
public class AdminProjectRestController {

    private final AdminProjectService adminProjectService;

    @GetMapping("/project/{id}")
    public ResponseEntity<ProjectResponseInfoDTO> getProject(@PathVariable Long id) {
        return ResponseEntity.ok(adminProjectService.findProject(id));
    }

    @GetMapping("/projects")
    public ResponseEntity<PageListResponseDTO<ProjectResponseInfoDTO>> getProjectList(
            @RequestParam int page,
            @RequestParam(required = false) String RS,
            @RequestParam(required = false) String PS,
            @RequestParam(required = false) String SD,
            @RequestParam(required = false) String ED,
            @RequestParam(required = false) String projname) {

        SearchTypeDTO searchTypeDTO = SearchTypeDTO.builder()
                .RS(RS)
                .PS(PS)
                .SD(SD)
                .ED(ED)
                .build();

        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
                .page(page)
                .search(searchTypeDTO)
                .projectName(projname)
                .build();

        PageListResponseDTO<ProjectResponseInfoDTO> data = adminProjectService.findProjectList(pageRequestDTO);
        return new ResponseEntity<>(data, HttpStatus.OK);
    }
}