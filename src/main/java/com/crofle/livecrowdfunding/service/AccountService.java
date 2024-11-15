package com.crofle.livecrowdfunding.service;

import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.dto.request.LoginRequestDTO;
import com.crofle.livecrowdfunding.dto.request.PageRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ProjectApprovalRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ResetPasswordRequestDTO;
import com.crofle.livecrowdfunding.dto.response.EssentialDocumentDTO;
import com.crofle.livecrowdfunding.dto.response.PageListResponseDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectResponseInfoDTO;
import com.crofle.livecrowdfunding.dto.response.TokenDTO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface AccountService {
    TokenDTO login(LoginRequestDTO loginRequest);

    TokenDTO refresh(String refreshToken);

    void sendResetPasswordEmail(ResetPasswordRequestDTO request);


    String generateResetPasswordLink(String email, String resetToken);



    // 이메일 찾기
    @Transactional(readOnly = true)
    Optional<AccountView> findEmailByNameAndPhone(String name, String phone);


}
