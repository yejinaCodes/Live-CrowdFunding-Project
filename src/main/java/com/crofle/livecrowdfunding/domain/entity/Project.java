package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.enums.Status;
import jakarta.persistence.*;
import org.apache.catalina.Manager;

import java.time.LocalDateTime;

@Entity
@Table(name = "PROJECT")
public class Project {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Maker maker; //Maker쪽에서 GeneratedValue 추가
    @ManyToOne
    private Manager manager; //Manager쪽에서 GeneratedValue 추가
    @OneToOne
    @JoinColumn(name="plan_id", referencedColumnName = "id")
    private RatePlan ratePlan;

    @OneToOne
    @JoinColumn(name="interest_id", referencedColumnName = "id")
    private Category category; //Catory 테이블에도 onetoone 추가
    private String productName;
    private String summary;

    private int price;
    private int discountPercentage;
    private LocalDateTime startAt;

    private LocalDateTime endAt;
    private int percentage;
    @Enumerated(EnumType.STRING)
    private Status reviewStatus;
    @Lob
    private String rejectionReason;
    @Enumerated(EnumType.STRING)
    private Status progressStatus;
    private int goalAmount;
    private String contentImage;




}
