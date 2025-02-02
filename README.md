![image](https://github.com/user-attachments/assets/e9619fa3-6fe7-491a-8ff3-b6786f7c4011)## CROFLE CROWDFUNDING SERVICE INTRODUCTION
<img width="585" alt="스크린샷 2025-02-02 오후 4 17 28" src="https://github.com/user-attachments/assets/422bb5d6-dc0a-462c-8e87-c9592b7176da" />

Crowdfunding is the act of raising funds from individuals through social networking services for small-scale donations or investments. 


<img width="1400" alt="스크린샷 2025-02-02 오후 4 23 32" src="https://github.com/user-attachments/assets/da49a1c3-769e-4934-b971-c83fd1119852" />

There is a clear trend in consumer demand for personalized items, which has positively influenced the growth of crowdfunding markets. 

However, challenges remain in ensuring the reliability of services, as funding is made possible even for incomplete or prototype product ideas. 

To address this issue, our team aimed to provide a crowdfunding platform that is **reliable**, **safe** and **interactive** for users. 

Our **Crofle** service:
1. Provides reliability to customers with practical information than photos. 
2. Enhances security with funding eligibility restricted through AI & admin review
3. Provides real-time two-way communication between sellers & consumers

## TEAM
|Yejin Kim|AA|BB|CC|
|:---:|:---:|:---:|:---:|
|Admin Page, Payment API|Main page, My page|Live Streaming, Chat Service|Frontend, Login|

## WORK BREAKDOWN STRUCTURE (WBS) SCHEDULE
<img width="802" alt="스크린샷 2025-02-02 오후 5 10 28" src="https://github.com/user-attachments/assets/de907ff1-8511-4851-a12f-05c7d4aefe3f" />

The project was carried out over a 6 week period.

## 1. DEVELOPMENT ENVIRONMENT
<img width="630" alt="스크린샷 2025-02-02 오후 4 37 54" src="https://github.com/user-attachments/assets/81b1f108-441a-45ab-91b0-906e0717cc6b" />

* FRONT-END: Vue3, HTML5, CSS3, JavaScript(ES6)
* BACK-END: Java(17), Spring Boot(3.3.4), JPA, Spring Security, Junit5, MediaSoup, Docker, MySQL(8.0.21), Redis
* VERSION CONTROL: Github, Git
* DEVELOPMENT TOOL: Visual Studio, Intellij IDE, MySQL Workbench
* COLLABORATION TOOL: Slack, Notion, GoogleDrive, Zoom


## 2. SERVER ARCHITECTURE
<img width="601" alt="스크린샷 2025-02-02 오후 4 37 08" src="https://github.com/user-attachments/assets/6a67044b-b1f0-4c6b-a860-a894c841ed6c" />

* Two-server configuration setup using Naver Cloud Platform (NCP)
* Nginx acts as a proxy server, routing client requests to the Vue.js and media servers
* In the private subnet, MySQL, Redis, and the Spring application are running in Docker containers, designed in a way that prevents direct external access


## 3. GITHUB CONVENTION

<img width="405" alt="image" src="https://github.com/user-attachments/assets/8981cf44-d128-429d-ae60-07a113253a58" />

<img width="233" alt="image" src="https://github.com/user-attachments/assets/bc0b5f5e-a99c-4d02-978e-f7668957aa73" />


[**FRONT-END CODE REPO 🔗**](https://github.com/yejinaCodes/Live-CrowdFunding-Frontend)


[**BACK-END CODE REPO 🔗**](https://github.com/yejinaCodes/Live-CrowdFunding-Project)


By managing the frontend and backend repositories separately, parallel work was possible, and independent deployment and scaling were possible


Through Continuous Integration, code changes were shared and integrated quickly, minimizing code conflicts.


## 4. BRANCH STRATEGY

<img width="320" alt="image" src="https://github.com/user-attachments/assets/5345f03f-e5ad-4864-bedd-1f484f696cf3" />

<img width="249" alt="image" src="https://github.com/user-attachments/assets/aded7e3f-7aec-4590-ab85-69be4fb84c67" />


**FRONT-END** Github Flow: Adopted for rapid changes and testing 

**BACK-END** Git Flow: Established stable deployment process through clear branch segmentation


## 5. PROJECT PACKAGE STRUCTURE & NAMING CONVENTION

<img width="220" alt="image" src="https://github.com/user-attachments/assets/a2389394-9391-446d-8cd0-6acc3d206a4e" />

<img width="420" alt="image" src="https://github.com/user-attachments/assets/794352b5-c176-4c77-88f3-d09b58970fac" />

## 6. COLLABORATION

<img width="596" alt="image" src="https://github.com/user-attachments/assets/be33a207-6352-495f-a690-8677bb4058cf" />

Our team adopted Agile methodology by conducting daily scrum meetings. Shared useful information and issue history through Notion.


## 7. FEATURE IMPLEMENTATION

<img width="280" alt="image" src="https://github.com/user-attachments/assets/79c5e38a-a782-4f04-81c0-0da984f55f8c" />

<img width="280" alt="image" src="https://github.com/user-attachments/assets/a9b65c3a-60ce-4bec-a6e1-e67310d8b8e6" />

<img width="914" alt="스크린샷 2025-02-02 오후 6 23 20" src="https://github.com/user-attachments/assets/fbb1e531-3548-4560-bade-658e6064300f" />



<img width="280" alt="image" src="https://github.com/user-attachments/assets/c430a63c-1602-42fd-81eb-176419f3a4ae" />


My contribution includes developing the admin page (JWT login, dashboard, project management, user management, report management), payment functionality implementation.

For more information please refer to my blog.
[**BLOG LINK 🔗**](https://velog.io/@lightamericano/%EC%8B%A4%EC%8B%9C%EA%B0%84-%EC%B1%84%ED%8C%85-%EA%B8%B0%EB%B0%98-%EB%9D%BC%EC%9D%B4%EB%B8%8C-%EC%BB%A4%EB%A8%B8%EC%8A%A4)

## 8. TROUBLE SHOOTING

1. Problem with Filler Plugin in Bar Chart of Chart.js

Compatibility issue with Filler plugin. The issue arose due to multiple graphs sharing the same bar.vue and line.vue components.

Solution: Adopted lazy loading pattern to dynamically load the plugin only when necessary.

2. Problem with setting additional trigger to the same table

Inability to use trigger that would change the funding status after project approval/denial due to already set trigger on the same stable.

The reason trigger cannot be applied to a table that already has a trigger is primarily due to database systems placing restrictions to prevent infinite loops or unintended side effects. 

Infinite calls not only degrade the performance of the DB, but also pose threat to overall stability of the system.

Solution: 




## 9. AREAS OF IMPROVEMENT

이메일 로직 정리: 디비 조회후 상태변경으로 진행, 1달 지난뒤 file에 저장하는 기능 추후 추가.
환불 규정에 따른 구현 추가 필요
security 적용 필요
디자인 패턴 적용 클린 코드 작성
대용량 트래픽이 생길 경우: 분산처리할 것으로 예상
common entity 및 코드 합칠 때 정리해줘야 함
Response entity를 같게 통일하는게 좋다?

## 10. RETROSPECTION

* I felt a lack of experience in simplifying backend architecture and writing clean code with design patterns. However, I plan to continue developing my skills through hands-on experience and learning to write more efficient and structured code.
* The importance of the dashboard became clear to me, as various statistics can help provide better services for managing crowdfunding projects. I want to further my knowledge in using data-driven insights to improve services.
* The successful completion of the project was largely due to continuous communication and collaboration with the team. This experience highlighted the importance of teamwork.

## 11. LINKS

[**NOTION 🔗**]()
[**ERD 🔗**]()


