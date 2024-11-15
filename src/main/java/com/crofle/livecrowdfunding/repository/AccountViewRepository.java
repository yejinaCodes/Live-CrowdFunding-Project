package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.AccountView;
import com.crofle.livecrowdfunding.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface AccountViewRepository extends JpaRepository<AccountView, Long> {

    Optional<AccountView> findByEmail(String email);

    //이메일 찾기
    @Query("SELECT u FROM AccountView u WHERE u.name = :name AND u.phone = :phone")
    Optional<AccountView> findEmailByNameAndPhone(@Param("name") String name, @Param("phone") String phone);


    @Query("SELECT u.email FROM AccountView u WHERE u.name = :name AND u.email = :email AND u.phone = :phone")
    String findEmailByNameAndMailAndPhone(@Param("name") String name, @Param("email") String email, @Param("phone") String phone);
}

