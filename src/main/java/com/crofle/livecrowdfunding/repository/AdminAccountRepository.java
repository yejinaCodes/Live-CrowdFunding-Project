package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.Manager;
import com.crofle.livecrowdfunding.dto.request.AdminAccountLoginRequestDTO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AdminAccountRepository extends JpaRepository<Manager, String> {
    Optional<Manager> findByIdNum(String IdNum);

}
