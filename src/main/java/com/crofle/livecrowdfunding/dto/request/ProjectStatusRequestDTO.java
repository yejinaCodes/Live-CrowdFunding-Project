package com.crofle.livecrowdfunding.dto.request;

import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectStatusRequestDTO {
    private ProjectStatus status;
}
