package com.crofle.livecrowdfunding.controller;

import com.crofle.livecrowdfunding.dto.request.LikedRequestDTO;
import com.crofle.livecrowdfunding.service.LikedService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/liked")
@Log4j2
public class LikedController {

    private final LikedService likedService;

    @PostMapping
    public ResponseEntity<Boolean> toggleLike(@RequestBody LikedRequestDTO likedRequestDTO) {
        return ResponseEntity.ok().body(likedService.toggleLike(likedRequestDTO));
    }
}
