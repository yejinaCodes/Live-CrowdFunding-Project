package com.crofle.livecrowdfunding.dto;

import com.crofle.livecrowdfunding.domain.entity.Image;
import com.crofle.livecrowdfunding.domain.entity.Project;
import lombok.*;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ImageDTO {
    private Long id;
    private String image;
}
