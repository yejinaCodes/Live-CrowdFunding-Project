package com.crofle.livecrowdfunding.service.serviceImpl;

import org.springframework.beans.factory.annotation.Value;
import com.crofle.livecrowdfunding.dto.request.ProposalRequest;
import com.crofle.livecrowdfunding.dto.response.ProposalAnalysisResponse;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
public class ProjectAnalysisService {

    @Value("${anthropic.api.key}")
    private String claudeApiKey;

    private static final String CLAUDE_API_URL = "https://api.anthropic.com/v1/messages";

    public ProposalAnalysisResponse analyzeProposals(ProposalRequest request) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("x-api-key", claudeApiKey);
            headers.set("anthropic-version", "2023-06-01");

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", "claude-3-5-sonnet-20241022");
            requestBody.put("max_tokens", 1000);
            requestBody.put("temperature", 0.3);
            requestBody.put("system", getSystemPrompt());  // system 메시지를 톱레벨 파라미터로 전달

            String userMessage = String.format("""
                기획안 1:
                %s
                
                기획안 2:
                %s
                """, request.getProposal1(), request.getProposal2());

            Map<String, String> message = new HashMap<>();
            message.put("role", "user");
            message.put("content", userMessage);

            List<Map<String, String>> messages = new ArrayList<>();
            messages.add(message);
            requestBody.put("messages", messages);

            HttpEntity<Map<String, Object>> httpRequest = new HttpEntity<>(requestBody, headers);
            RestTemplate restTemplate = new RestTemplate();

            ResponseEntity<JsonNode> response = restTemplate.exchange(
                    CLAUDE_API_URL,
                    HttpMethod.POST,
                    httpRequest,
                    JsonNode.class
            );

            return parseResponse(response.getBody());

        } catch (Exception e) {
            log.error("Claude API 호출 중 오류 발생", e);
            throw new RuntimeException("기획안 분석 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    private String getSystemPrompt() {
        return """
            당신은 사업 기획안을 평가하는 전문가입니다. 아래 기준으로 두 기획안을 평가해주세요:
            
            1. 시장성 (30점)
               - 시장 규모와 성장성
               - 고객 니즈 부합도
            
            2. 실현 가능성 (30점)
               - 기술적/운영적 실현 가능성
               - 자원 소요 적절성
            
            3. 수익성 (20점)
               - 수익 모델의 명확성
               - 예상 수익률
            
            4. 차별성 (20점)
               - 경쟁사 대비 강점
               - 혁신성
            
            기획안 분석 결과는 100점 만점으로 산출됩니다. 80점 이상이면 통과로 간주합니다.
            기획안 분석 결과는 각 항목 별 점수를 제공해주면 됩니다.
           
            다음 형식으로 JSON으로 응답해주세요:
            {
                "proposal1Score": 점수,
                "proposal2Score": 점수,
                "analysis": "기획안 분석 결과"
            }
            """;
    }

    private ProposalAnalysisResponse parseResponse(JsonNode responseBody) {
        try {
            JsonNode content = responseBody.get("content").get(0).get("text");
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(content.asText());

            return ProposalAnalysisResponse.builder()
                    .proposal1Score(rootNode.get("proposal1Score").asDouble())
                    .proposal2Score(rootNode.get("proposal2Score").asDouble())
                    .analysis(rootNode.get("analysis").asText())
                    .passesThreshold(
                            rootNode.get("proposal1Score").asDouble() >= 80 ||
                                    rootNode.get("proposal2Score").asDouble() >= 80
                    )
                    .build();

        } catch (Exception e) {
            log.error("응답 파싱 중 오류 발생: {}", e.getMessage(), e);
            throw new RuntimeException("AI 응답 분석 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
}