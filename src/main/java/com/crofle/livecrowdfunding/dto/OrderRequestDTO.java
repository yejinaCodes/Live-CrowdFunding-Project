package com.crofle.livecrowdfunding.dto;

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
    private User user;
    private Project project;
    private Integer amount;
}
