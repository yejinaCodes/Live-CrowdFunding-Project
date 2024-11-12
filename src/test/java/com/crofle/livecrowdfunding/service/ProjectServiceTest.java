package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.dto.ProjectDetailDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Log4j2
public class ProjectServiceTest {
    @Autowired
    private ProjectService projectService;

    @Test
    public void testFindProjectDetail() {
        Long id = 1L;
        ProjectDetailDTO projectDetailDTO = projectService.findProjectDetail(id);
        log.info(projectDetailDTO);
    }
}
