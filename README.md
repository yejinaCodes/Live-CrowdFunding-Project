## CROFLE CROWDFUNDING SERVICE INTRODUCTION
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

* Front-end: Vue3, HTML5, CSS3, JavaScript(ES6)
* Back-end: Java(17), Spring Boot(3.3.4), JPA, Spring Security, Junit5, MediaSoup, Docker, MySQL(8.0.21), Redis
* Version Control: Github, Git
* Development Tool: Visual Studio, Intellij IDE, MySQL Workbench
* Collaboration Tool: Slack, Notion, GoogleDrive, Zoom


## 2. SERVER ARCHITECTURE
<img width="601" alt="스크린샷 2025-02-02 오후 4 37 08" src="https://github.com/user-attachments/assets/6a67044b-b1f0-4c6b-a860-a894c841ed6c" />

* Two-server configuration setup using Naver Cloud Platform (NCP)
* Nginx acts as a proxy server, routing client requests to the Vue.js and media servers
* In the private subnet, MySQL, Redis, and the Spring application are running in Docker containers, designed in a way that prevents direct external access


## 3. GITHUB CONVENTION

<img width="350" alt="image" src="https://github.com/user-attachments/assets/8981cf44-d128-429d-ae60-07a113253a58" />

<img width="200" alt="image" src="https://github.com/user-attachments/assets/bc0b5f5e-a99c-4d02-978e-f7668957aa73" />


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

<img width="200" alt="image" src="https://github.com/user-attachments/assets/a2389394-9391-446d-8cd0-6acc3d206a4e" />

<img width="320" alt="image" src="https://github.com/user-attachments/assets/794352b5-c176-4c77-88f3-d09b58970fac" />

## 6. COLLABORATION

<img width="596" alt="image" src="https://github.com/user-attachments/assets/be33a207-6352-495f-a690-8677bb4058cf" />

Our team adopted Agile methodology by conducting daily scrum meetings. Shared useful information and issue history through Notion.


## 7. FEATURE IMPLEMENTATION

https://github.com/user-attachments/assets/0b76cbe8-4cec-4530-bc68-ad6001d27432

My contribution includes developing the admin page (JWT login, dashboard statistics, project management, user management, report management), Toss Payment API integration for 2 types of payment logic.

For more information please refer to my blog.

[**BLOG LINK 🔗**](https://velog.io/@lightamericano/%EC%8B%A4%EC%8B%9C%EA%B0%84-%EC%B1%84%ED%8C%85-%EA%B8%B0%EB%B0%98-%EB%9D%BC%EC%9D%B4%EB%B8%8C-%EC%BB%A4%EB%A8%B8%EC%8A%A4)

## 8. TROUBLE SHOOTING

1. Problem with Filler Plugin in Bar Chart of Chart.js
* Compatibility issue with Filler plugin. The issue arose due to multiple graphs sharing the same bar.vue and line.vue components.
* Solution: Adopted lazy loading pattern to dynamically load the plugin only when necessary.
  
2. Problem with setting additional trigger to the same table
* Inability to use trigger that would change the funding status after project approval/denial due to already set trigger on the same stable.
* The reason trigger cannot be applied to a table that already has a trigger is primarily due to database systems placing restrictions to prevent infinite loops or unintended side effects. 
* Infinite calls not only degrade the performance of the DB, but also pose threat to overall stability of the system.
* Solution: Avoid trigger and manage status update within the backend business logic

## 9. AREAS OF IMPROVEMENT

* Refine
  - Unify the Response entity to improve readability
  - Study then apply relevant design patterns and write cleaner code
    
* Add
  - Implement refund policy logic
  - Add feature to save reports and top funding data to a file at monthly intervals
  - Distribute processing in case of high traffic volume


## 10. RETROSPECTION

I felt a lack of experience in simplifying backend architecture and writing clean code with design patterns. However, I plan to continue developing my skills through hands-on experience and learning to write more efficient and structured code.

Also, the importance of the dashboard became clear to me, as various statistics can help provide better services for managing crowdfunding projects. I want to further my knowledge in using data-driven insights to improve services.

The successful completion of the project was largely due to continuous communication and collaboration with the team. This experience highlighted the importance of teamwork.

## 11. LINKS

[**NOTION 🔗**](https://short-measure-b6e.notion.site/4-12630b3d969f808894eed78fea456c01)

[**ERD 🔗**](https://www.erdcloud.com/d/KYPmJkkarumbWEtCu)


