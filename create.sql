
    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason tinytext,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge bit not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event bigint not null,
        event_id bigint not null,
        user bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event, user)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);

    create table category (
        id bigint not null auto_increment,
        classification varchar(30) not null,
        primary key (id)
    ) engine=InnoDB;

    create table chat_report (
        created_at datetime(6) not null,
        id bigint not null auto_increment,
        manager_id bigint not null,
        project_id bigint not null,
        user_id bigint not null,
        chat_message varchar(255) not null,
        reason varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table essential_document (
        id bigint not null auto_increment,
        project_id bigint not null,
        document varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event (
        max_participants integer not null,
        created_at datetime(6) not null,
        event_id bigint not null auto_increment,
        project_id bigint not null,
        updated_at datetime(6),
        content varchar(30),
        name varchar(30) not null,
        prize varchar(255) not null,
        primary key (event_id)
    ) engine=InnoDB;

    create table event_log (
        created_at datetime(6) not null,
        event_id bigint not null,
        user_id bigint not null,
        winning_data datetime(6) not null,
        winning_prize varchar(255) not null,
        primary key (event_id, user_id)
    ) engine=InnoDB;

    create table image (
        id bigint not null auto_increment,
        project_id bigint not null,
        image varchar(200) not null,
        primary key (id)
    ) engine=InnoDB;

    create table liked (
        created_at datetime(6) not null,
        project_id bigint not null,
        user_id bigint not null,
        primary key (project_id, user_id)
    ) engine=InnoDB;

    create table maker (
        business integer not null,
        register_status integer not null,
        status integer not null comment '0: 활성, 1: 탈퇴',
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        name varchar(20) not null,
        password varchar(20) not null,
        phone varchar(20) not null,
        address varchar(30) not null,
        email varchar(30) not null,
        detail_address varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table manager (
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        identification_number varchar(20) not null,
        name varchar(20) not null,
        phone varchar(20) not null,
        email varchar(50) not null,
        password varchar(50) not null,
        primary key (id)
    ) engine=InnoDB;

    create table orders (
        amount integer not null,
        payment_price integer not null,
        id bigint not null auto_increment,
        project_id bigint not null,
        user_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table payment_history (
        refund_status integer not null comment '0: No, 1: YES',
        order_id bigint not null,
        payment_at datetime(6) not null,
        delivery_address varchar(30) not null,
        payment_method enum ('계좌이체','모바일','카드') not null,
        primary key (order_id)
    ) engine=InnoDB;

    create table project (
        discount_percentage integer,
        goal_amount integer not null,
        percentage integer not null,
        price integer not null,
        category_id bigint not null,
        end_at datetime(6),
        id bigint not null auto_increment,
        maker_id bigint not null,
        manager_id bigint,
        plan_id bigint not null,
        start_at datetime(6),
        product_name varchar(20) not null,
        summary varchar(50) not null,
        content_image varchar(200) not null,
        progress_status enum ('검토중','미달성','반려','성공','승인','펀딩중'),
        rejection_reason LONGTEXT,
        review_status enum ('검토중','미달성','반려','성공','승인','펀딩중') not null,
        primary key (id)
    ) engine=InnoDB;

    create table rate_plan (
        charge smallint not null,
        id bigint not null auto_increment,
        plan_name varchar(20) not null,
        primary key (id)
    ) engine=InnoDB;

    create table revenue (
        total_amount integer not null comment '프로젝트 성공 후 결산',
        project_id bigint not null,
        primary key (project_id)
    ) engine=InnoDB;

    create table schedule (
        date datetime(6),
        id bigint not null auto_increment,
        project_id bigint not null,
        primary key (id)
    ) engine=InnoDB;

    create table script (
        id bigint not null auto_increment,
        script_url varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table top_funding (
        ranking INT UNSIGNED not null,
        id BIGINT UNSIGNED not null,
        project_id bigint not null,
        updated_at datetime(6) not null,
        primary key (id, project_id)
    ) engine=InnoDB;

    create table user_interest (
        category_id bigint not null,
        user_id bigint not null,
        primary key (category_id, user_id)
    ) engine=InnoDB;

    create table users (
        gender bit not null,
        login_method bit not null,
        notification bit not null,
        zipcode integer not null,
        id bigint not null auto_increment,
        registered_at datetime(6) not null,
        unregistered_at datetime(6),
        birth varchar(10) not null,
        email varchar(20) not null,
        name varchar(30) not null,
        nickname varchar(30),
        phone varchar(30) not null,
        address varchar(50) not null,
        detail_address varchar(50) not null,
        password varchar(50) not null,
        status enum ('비활성화','정지','활성화') not null,
        primary key (id)
    ) engine=InnoDB;

    create table video (
        schedule_id bigint not null,
        media_url varchar(255) not null,
        primary key (schedule_id)
    ) engine=InnoDB;

    alter table users 
       add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

    alter table chat_report 
       add constraint FKa43c9fturkouwjad84sw1acuq 
       foreign key (manager_id) 
       references manager (id);

    alter table chat_report 
       add constraint FKeu4jcv7h7mqand4r0drjphyd 
       foreign key (project_id) 
       references project (id);

    alter table chat_report 
       add constraint FKppsdh4idirwd3mfnww9bo3jjr 
       foreign key (user_id) 
       references users (id);

    alter table essential_document 
       add constraint FKqngi5dilfynextt2xn1c2jkvb 
       foreign key (project_id) 
       references project (id);

    alter table event 
       add constraint FKan4fyegy93oot7nvfo7suce71 
       foreign key (project_id) 
       references project (id);

    alter table event_log 
       add constraint FK6nfr91yswffulr85jjwtc52yc 
       foreign key (event_id) 
       references event (event_id);

    alter table event_log 
       add constraint FK5suo161qrly45vrg00lqhqrn8 
       foreign key (user_id) 
       references users (id);

    alter table image 
       add constraint FK8pvrnu8pectugcu3evcb364vx 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKc95ht8g548c41xf1e4voj7e8n 
       foreign key (project_id) 
       references project (id);

    alter table liked 
       add constraint FKcc0jrw2vianbjig6suh66syiw 
       foreign key (user_id) 
       references users (id);

    alter table orders 
       add constraint FKbb45vapgetg0v0uw4913rr82y 
       foreign key (project_id) 
       references project (id);

    alter table orders 
       add constraint FK32ql8ubntj5uh44ph9659tiih 
       foreign key (user_id) 
       references users (id);

    alter table payment_history 
       add constraint FKn278ec2ny1ai0e8hikff93x43 
       foreign key (order_id) 
       references orders (id);

    alter table project 
       add constraint FKe0w7gh0rpmxo35nltk6g8517q 
       foreign key (category_id) 
       references category (id);

    alter table project 
       add constraint FKcf3xn6841jcaijvqesp19gjox 
       foreign key (maker_id) 
       references maker (id);

    alter table project 
       add constraint FKmc41im0glyrn8n6u6yfyuy38s 
       foreign key (manager_id) 
       references manager (id);

    alter table project 
       add constraint FKn83rrnp7mbf5ikkyuajx4aswe 
       foreign key (plan_id) 
       references rate_plan (id);

    alter table revenue 
       add constraint FK5jp6oi2vmuthw6gmy61oyq0jr 
       foreign key (project_id) 
       references project (id);

    alter table schedule 
       add constraint FK86b2w5apjrmn6d17rdn475dm5 
       foreign key (project_id) 
       references project (id);

    alter table top_funding 
       add constraint FKkn7vm1lkvxi56bsrt5kk86r69 
       foreign key (project_id) 
       references project (id);

    alter table user_interest 
       add constraint FK25swxjvbuqcjoov4jphqb3s5t 
       foreign key (category_id) 
       references category (id);

    alter table user_interest 
       add constraint FK97yodomof0ffqwpnt9obp1l6c 
       foreign key (user_id) 
       references users (id);

    alter table video 
       add constraint FK820lbb6nsrlbscmsemrrlxiur 
       foreign key (schedule_id) 
       references schedule (id);
