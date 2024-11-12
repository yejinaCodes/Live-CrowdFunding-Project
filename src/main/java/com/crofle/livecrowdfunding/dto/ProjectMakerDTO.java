package com.crofle.livecrowdfunding.dto;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Comment;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ProjectMakerDTO {  //프로젝트 상세 페이지에 필요한 메이커 정보
    private Long id;
    private String name;
}
