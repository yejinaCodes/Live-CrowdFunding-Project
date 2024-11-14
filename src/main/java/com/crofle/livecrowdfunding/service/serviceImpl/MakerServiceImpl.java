package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Maker;
import com.crofle.livecrowdfunding.dto.request.MakerInfoRequestDTO;
import com.crofle.livecrowdfunding.dto.response.MakerInfoResponseDTO;
import com.crofle.livecrowdfunding.repository.MakerRepository;
import com.crofle.livecrowdfunding.service.MakerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
