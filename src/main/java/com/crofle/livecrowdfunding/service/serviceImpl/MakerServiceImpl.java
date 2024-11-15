package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Maker;
import com.crofle.livecrowdfunding.dto.request.MakerInfoRequestDTO;
import com.crofle.livecrowdfunding.dto.response.MakerInfoResponseDTO;
import com.crofle.livecrowdfunding.dto.request.SaveMakerRequestDTO;
import com.crofle.livecrowdfunding.repository.MakerRepository;
import com.crofle.livecrowdfunding.service.MakerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Log4j2
public class MakerServiceImpl implements MakerService {

    private final MakerRepository makerRepository;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public MakerInfoResponseDTO findMaker(Long makerId) {
        Maker maker = makerRepository.findById(makerId).orElseThrow(() -> new IllegalArgumentException("해당 메이커가 존재하지 않습니다."));

        return modelMapper.map(maker, MakerInfoResponseDTO.class);
    }

    @Override
    @Transactional
    public void updateMaker(Long id, MakerInfoRequestDTO makerInfoRequestDTO) {
        Maker maker = makerRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 메이커가 존재하지 않습니다."));

        maker.updateMakerInfo(makerInfoRequestDTO);
    }
}

    //판매자 회원가입
    @Override
    public SaveMakerRequestDTO saveMaker(SaveMakerRequestDTO saveMakerRequestDTO) {

        Maker maker = Maker.builder()
                .name(saveMakerRequestDTO.getName())
                .phone(saveMakerRequestDTO.getPhone())
                .business(saveMakerRequestDTO.getBusiness())
                .email(saveMakerRequestDTO.getEmail())
                .password(saveMakerRequestDTO.getPassword())
                .zipcode(saveMakerRequestDTO.getZipcode())
                .address(saveMakerRequestDTO.getAddress())
                .detailAddress(saveMakerRequestDTO.getDetailAddress())
                .registeredAt(LocalDateTime.now())
                .status(0)
                .build();

        maker = makerRepository.save(maker);
        log.info("메이커 정보 저장 완료");

        return saveMakerRequestDTO;
    }
}
