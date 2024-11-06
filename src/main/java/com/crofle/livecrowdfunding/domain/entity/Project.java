package com.crofle.livecrowdfunding.domain.entity;

import com.crofle.livecrowdfunding.domain.enums.Status;
import jakarta.persistence.*;
import org.apache.catalina.Manager;

import java.time.LocalDateTime;

@Entity
public class Project {
    @Id
    private Long id;

    @ManyToOne
    private Maker maker_id; //Maker쪽에서 GeneratedValue 추가
    @ManyToOne
    private Manager manager_id; //Manager쪽에서 GeneratedValue 추가
    @OneToOne
    @JoinColumn(name="plan_id", referencedColumnName = "id")
    private RatePlan ratePlan;

    private Long interest_id;
    private String product_name;
    private String summary;

    private int price;
    private int discount_percentage;
    private LocalDateTime start_at;

    private LocalDateTime end_at;
    private int percentage;
    @Enumerated(EnumType.STRING)
    private Status review_status;
    @Lob
    private String rejection_reason;
    @Enumerated(EnumType.STRING)
    private Status progress_status;
    private int goal_amount;
    private String content_image;




}
