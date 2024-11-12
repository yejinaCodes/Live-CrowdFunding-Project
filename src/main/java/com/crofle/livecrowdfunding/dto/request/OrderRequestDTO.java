package com.crofle.livecrowdfunding.dto.request;

import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.entity.User;
import lombok.*;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class OrderRequestDTO {
    private Long id;
    private Long userId;
    private Long projectId;
    private Integer amount;
}
