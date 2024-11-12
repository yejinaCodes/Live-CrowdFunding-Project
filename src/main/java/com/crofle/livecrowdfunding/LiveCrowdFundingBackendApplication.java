package com.crofle.livecrowdfunding;

import com.crofle.livecrowdfunding.dto.response.ProjectResponseInfoDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.service.AdminProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication
public class LiveCrowdFundingBackendApplication {
	@Autowired
	private AdminProjectService adminProjectService;

	public static void main(String[] args) {
		ConfigurableApplicationContext context = SpringApplication.run(LiveCrowdFundingBackendApplication.class, args);
		LiveCrowdFundingBackendApplication lf = context.getBean(LiveCrowdFundingBackendApplication.class);
//		LiveCrowdFundingBackendApplication liveCF = new LiveCrowdFundingBackendApplication();
		lf.callProject();
	}
	public void callProject(){
		System.out.println("checking");
		ProjectResponseInfoDTO result = adminProjectService.findProject(1L);

		adminProjectService.findProjectList(new PageRequestDTO());

	}

}
