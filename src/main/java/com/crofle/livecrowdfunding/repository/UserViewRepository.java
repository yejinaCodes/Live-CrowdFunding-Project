package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.UserView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserViewRepository extends JpaRepository<UserView, Long> {

    @Query("SELECT u.email FROM UserView u WHERE u.name = :name AND u.phone = :phone")
    String findEmailByNameAndPhoneNumber(@Param("name") String name, @Param("phone") String phone);
}
