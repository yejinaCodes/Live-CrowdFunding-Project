package com.crofle.livecrowdfunding.dto.request;

import com.crofle.livecrowdfunding.domain.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
// OAuth 로그인 요청
public class AccountOAuthRequestDTO {  // OAuth 로그인 요청
    private String email;
    private String name;
    private Role role;
}