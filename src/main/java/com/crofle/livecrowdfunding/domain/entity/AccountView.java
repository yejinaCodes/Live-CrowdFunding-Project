package com.crofle.livecrowdfunding.domain.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "user_view")
public class AccountView { // 클래스 접근 제어자를 public으로 변경
    @Id
    private Long id;
    private String name;
    private String phone;
    private String email;
}
