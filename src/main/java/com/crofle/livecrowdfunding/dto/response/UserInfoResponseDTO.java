package com.crofle.livecrowdfunding.dto.response;

import com.crofle.livecrowdfunding.domain.enums.UserStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserInfoResponseDTO {
    private Long id;
    private String name;
    private String nickname;
    private String phone;
    private Boolean gender;
    private String birth;
    private String email;
    private String password;
    private Integer zipcode;
    private String address;
    private String detailAddress;
    private Boolean loginMethod;
    private LocalDateTime registeredAt;
    private LocalDateTime unregisteredAt;
    private UserStatus status;
    private Boolean notification;
}
