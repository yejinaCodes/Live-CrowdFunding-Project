package com.crofle.livecrowdfunding.config;

import com.crofle.livecrowdfunding.domain.entity.ChatReport;
import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.dto.response.ChatReportListDTO;
import com.crofle.livecrowdfunding.dto.response.ProjectResponseInfoDTO;
import org.hibernate.collection.spi.PersistentBag;
import org.modelmapper.Converter;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Configuration
public class ModelMapperConfig {

    @Bean
    @Primary
    public ModelMapper getMapper() {
        ModelMapper modelMapper = new ModelMapper();
        modelMapper.getConfiguration()
                .setFieldMatchingEnabled(true)
                .setFieldAccessLevel(org.modelmapper.config.Configuration.AccessLevel.PRIVATE)
                .setMatchingStrategy(MatchingStrategies.STRICT);

        return modelMapper;
    }

//    //Chat 리스트 조회시 사용
//    @Bean(name="ChatmodelMapper")
//    public ModelMapper ChatmodelMapper() {
//        ModelMapper modelMapper = new ModelMapper();
//
//        modelMapper.createTypeMap(Project.class, ProjectResponseInfoDTO.class);
//
//        modelMapper.createTypeMap(ChatReport.class, ChatReportListDTO.class)
//                .addMappings(mapper -> {
//                    mapper.map(src -> src.getProject(), ChatReportListDTO::setProject);
//                    mapper.map(src -> src.getUser(), ChatReportListDTO::setUser);
//                    mapper.map(ChatReport::getChatMessage, ChatReportListDTO::setChatMessage);
//                    mapper.map(ChatReport::getCreatedAt, ChatReportListDTO::setCreatedAt);
//                });
//
//        return modelMapper;
//    }
}