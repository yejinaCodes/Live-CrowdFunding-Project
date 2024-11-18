package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.request.ProposalRequest;
import com.crofle.livecrowdfunding.dto.response.ProposalAnalysisResponse;
import com.crofle.livecrowdfunding.service.serviceImpl.ProjectAnalysisService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/proposals")
public class ProposalAnalysisController {

    private final ProjectAnalysisService analysisService;

    @Autowired
    public ProposalAnalysisController(ProjectAnalysisService analysisService) {
        this.analysisService = analysisService;
    }

    @PostMapping("/analyze")
    public ResponseEntity<ProposalAnalysisResponse> analyzeProposals(
            @RequestBody ProposalRequest request) {
        ProposalAnalysisResponse analysis = analysisService.analyzeProposals(request);
        return ResponseEntity.ok(analysis);
    }
}
