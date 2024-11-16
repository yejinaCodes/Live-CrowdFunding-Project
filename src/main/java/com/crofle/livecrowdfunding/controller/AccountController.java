package com.crofle.livecrowdfunding.controller;


import com.crofle.livecrowdfunding.dto.request.*;
import com.crofle.livecrowdfunding.dto.response.AccountTokenResponseDTO;
import com.crofle.livecrowdfunding.service.AccountService;
import com.crofle.livecrowdfunding.service.MakerService;
import com.crofle.livecrowdfunding.service.UserService;
import com.crofle.livecrowdfunding.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/account")
@RequiredArgsConstructor
@Log4j2
public class AccountController {
    private final AccountService accountService;
    private final UserService userService;
    private final MakerService makerService;
    private final JwtUtil jwtUtil; // JwtUtil 필드 추가

    @PostMapping("/register/user")
    public ResponseEntity<SaveUserRequestDTO> registerUser(@RequestBody SaveUserRequestDTO request) {
        return ResponseEntity.ok(userService.saveUser(request));
    }

    @PostMapping("/register/maker")
    public ResponseEntity<SaveMakerRequestDTO> registerMaker(@RequestBody SaveMakerRequestDTO request) {
        return ResponseEntity.ok(makerService.saveMaker(request));
    }

    @PostMapping("/login")
    public ResponseEntity<AccountTokenResponseDTO> login(@RequestBody AccountLoginRequestDTO request) {
        return ResponseEntity.ok(accountService.login(request));
    }

    @PostMapping("/refresh")
    public ResponseEntity<AccountTokenResponseDTO> refresh(
            @RequestHeader("Authorization") String refreshToken,
            @RequestHeader("AccessToken") String accessToken) {
        AccountTokenRequestDTO request = AccountTokenRequestDTO.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
        return ResponseEntity.ok(accountService.refresh(request));
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader("Authorization") String token) {
        String email = jwtUtil.getEmailFromToken(token);
        accountService.logout(email);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/find-email")
    public ResponseEntity<?> findEmail(@RequestParam String name, @RequestParam String phone) {
        AccountFindEmailRequestDTO request = AccountFindEmailRequestDTO.builder()
                .name(name)
                .phone(phone)
                .build();
        return accountService.findEmailByNameAndPhone(request)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody AccountPasswordResetRequestDTO request) {
        accountService.sendResetPasswordEmail(request);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/oauth")
    public ResponseEntity<AccountTokenResponseDTO> oauthLogin(@RequestBody AccountOAuthRequestDTO request) {
        return ResponseEntity.ok(accountService.authenticateOAuthAccount(request));
    }
}