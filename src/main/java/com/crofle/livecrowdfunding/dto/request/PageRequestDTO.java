package com.crofle.livecrowdfunding.dto.request;

import com.crofle.livecrowdfunding.dto.SearchTypeDTO;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Positive;
import lombok.*;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class PageRequestDTO {

    @Builder.Default
    @Min(value = 1)
    @Positive
    private int page = 1;

    @Builder.Default
    @Min(value = 10)
    private int size = 10;

    @Builder.Default
    private String orderBy = "id";

    @Builder.Default
    private String orderByDir = "DESC";

    private SearchTypeDTO search = new SearchTypeDTO();

    //검색 조건으로 프로젝트 이름명 조회 가능
    private String projectName;
    public int getOffset(){
        return (page - 1) * 10;
    }


}
