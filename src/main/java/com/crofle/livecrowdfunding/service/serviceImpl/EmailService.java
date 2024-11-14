package com.crofle.livecrowdfunding.service.serviceImpl;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@Log4j2
public class EmailService {
    @Autowired
    private JavaMailSender emailSender;

    //단순 문제 메일 보내기
    public void sendEmail(String to, String subject, String text){

    }

}
