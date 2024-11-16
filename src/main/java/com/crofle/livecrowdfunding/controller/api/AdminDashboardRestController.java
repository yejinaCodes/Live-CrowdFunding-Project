package com.crofle.livecrowdfunding.controller.api;

import com.crofle.livecrowdfunding.dto.response.*;
import com.crofle.livecrowdfunding.service.AdminDashBoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/api")
public class AdminDashboardRestController {
    LocalDateTime now = LocalDateTime.now();
    LocalDateTime oneYearAgo = now.minusYears(1);

    //프론트에서 Fetchall 사용해 개별 엔드포인트 병렬 호출
    public final AdminDashBoardService dashBoardService;

    //동시성 제어 사용시 axios사용
    @GetMapping("/dashboard/stats")
    public ResponseEntity<StatisticsResponseDTO>getStats(){

    }
    //월별(최근 12개월) 신규 가입자 수 (일반회원, 메이커, 총계)
    @GetMapping("/dashboard/new-users")
    public ResponseEntity<UserGraphResponseDTO>getNewUsers(){
        UserGraphResponseDTO userStats = UserGraphResponseDTO.builder()
                .labels(dashBoardService.getLast12Months())
                .users()
                .makers()
                .total()
                .build();
    }

    @GetMapping("/dashboard/GraphB")
    public ResponseEntity<RevenueGraphResponseDTO>getTotalRevenue(){

    }
    @GetMapping("/dashboard/GraphC")
    public ResponseEntity<PopularFundingResponseDTO>getPopularFunding(){

    }
    @GetMapping("/dashboard/GraphD")
    public ResponseEntity<CurrentUserGraphResponseDTO>getCurrentUsers(){

    }
    @GetMapping("/dashboard/GraphE")
    public ResponseEntity<CategoryRevenueResponseDTO>getCategoryRevenue(){

    }
}
