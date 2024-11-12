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
    //dto로 변환하던가 id로 받던가
    private User user;
    private Project project;
    private Integer amount;
}
