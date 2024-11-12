package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.ProjectInfoDTO;
import com.crofle.livecrowdfunding.service.AdminProjectService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;

@Controller
@Log4j2
@RequiredArgsConstructor
//Controller는 api/web 어떻게 나눌지 정하고 진행하기..!
public class AdminProject {
    private final AdminProjectService adminProjectService;

    public void getProject() {
        int testid = 1;
        ProjectInfoDTO projectInfoDTO = adminProjectService.findProject((long) testid);
        log.info(projectInfoDTO.toString());

    }

}
