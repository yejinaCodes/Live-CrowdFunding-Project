package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.dto.request.LoginRequestDTO;
import com.crofle.livecrowdfunding.dto.request.ResetPasswordRequestDTO;
import com.crofle.livecrowdfunding.dto.response.TokenDTO;
import com.crofle.livecrowdfunding.service.AccountService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/account")
@RequiredArgsConstructor
@Log4j2
public class AccountController {
    private final AccountService accountService;

    @PostMapping("/login")
    public ResponseEntity<TokenDTO> login(@RequestBody LoginRequestDTO request) {
        TokenDTO token = accountService.login(request);
        return ResponseEntity.ok(token);
    }

    @PostMapping("/refresh")
    public ResponseEntity<TokenDTO> refresh(@RequestHeader("Authorization") String refreshToken) {
        TokenDTO token = accountService.refresh(refreshToken);
        return ResponseEntity.ok(token);
    }

    @PostMapping("/find-email")
    public ResponseEntity<?> findEmail(@RequestParam String name, @RequestParam String phone) {
        Optional<AccountView> result = accountService.findEmailByNameAndPhone(name, phone);
        return result.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody ResetPasswordRequestDTO request) {
        accountService.sendResetPasswordEmail(request);
        return ResponseEntity.ok().build();
    }
}