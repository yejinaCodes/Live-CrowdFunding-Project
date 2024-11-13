package com.crofle.livecrowdfunding.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

import java.util.List;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class SaveMakerDTO {
    private Long id;
    private String name;
    private String phone;
    private Integer business;
    private String email;
    private String password;
    private Integer zipcode;
    private String address;
    private String detailAddress;
}
