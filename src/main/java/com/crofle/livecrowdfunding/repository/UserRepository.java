package com.crofle.livecrowdfunding.repository;

import com.crofle.livecrowdfunding.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

}
