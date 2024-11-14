package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Maker;
import com.crofle.livecrowdfunding.dto.SaveMakerDTO;
import com.crofle.livecrowdfunding.repository.MakerRepository;
import com.crofle.livecrowdfunding.service.MakerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Log4j2
public class MakerServiceImpl implements MakerService {


    private final MakerRepository makerRepository;

    //판매자 회원가입
    @Override
    public SaveMakerDTO saveMaker(SaveMakerDTO saveMakerDTO) {

        Maker maker = Maker.builder()
                .name(saveMakerDTO.getName())
                .phone(saveMakerDTO.getPhone())
                .business(saveMakerDTO.getBusiness())
                .email(saveMakerDTO.getEmail())
                .password(saveMakerDTO.getPassword())
                .zipcode(saveMakerDTO.getZipcode())
                .address(saveMakerDTO.getAddress())
                .detailAddress(saveMakerDTO.getDetailAddress())
                .registeredAt(LocalDateTime.now())
                .status(0)
                .build();

        maker = makerRepository.save(maker);
        log.info("메이커 정보 저장 완료");

        return saveMakerDTO;
    }



}