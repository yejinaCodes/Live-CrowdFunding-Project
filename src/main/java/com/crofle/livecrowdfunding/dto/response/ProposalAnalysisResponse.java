package com.crofle.livecrowdfunding.dto.response;

import lombok.*;

@Data
@RequiredArgsConstructor
@AllArgsConstructor
@Builder
public class ProposalAnalysisResponse {
    private double proposal1Score;
    private double proposal2Score;
    private String analysis;
    private boolean passesThreshold;

    public boolean bothPass() {
        return proposal1Score >= 80 && proposal2Score >= 80;
    }

    public boolean eitherPasses() {
        return passesThreshold;
    }
}
