package com.crofle.livecrowdfunding;

import com.crofle.livecrowdfunding.domain.EventLogId;
import com.crofle.livecrowdfunding.domain.UserCategoryId;
import com.crofle.livecrowdfunding.domain.entity.*;
import com.crofle.livecrowdfunding.domain.enums.UserStatus;
import com.crofle.livecrowdfunding.repository.*;
import jakarta.persistence.EntityManager;
import lombok.extern.log4j.Log4j2;
import org.hibernate.validator.internal.util.logging.Log;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.AssertionsForInterfaceTypes.assertThat;

@Log4j2
@SpringBootTest
@Rollback(false)
@Transactional
public class TestEntity {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private UserInterestRepository userInterestRepository;

    @Autowired
    private ManagerRepository managerRepository;

    @Autowired
    private ChatReportRepository chatReportRepository;

    @Autowired
    private MakerRepository makerRepository;

    @Autowired
    private ScheduleRepository scheduleRepository;

    @Autowired
    private ScriptRepository scriptRepository;

    @Autowired
    private VideoRepository videoRepository;

    @Autowired
    private EventRepository eventRepository;

    @Autowired
    private EventLogRepository eventLogRepository;

    @Test
    public void categoryEntityTest() {
        List<Category> categories = categoryRepository.findAll();
        for (Category category : categories) {
            log.info(category);
        }
    }

    @Test
    @Transactional
    void checkRelationshipUsingRepository() {
        Category category = categoryRepository.findById(1L).orElseThrow();

        category.getProjects().forEach(project -> {
            log.info(project);
        });
    }

    @Test
    @DisplayName("UserInterest 생성 및 연관관계 매핑 테스트")
    void createAndCheckRelationship() {
        // Given
        User user = User.builder()
                .name("테스트유저002")
                .nickname("테스트닉네임")
                .phone("010-1234-5678")
                .gender(true)
                .birth("19900101")
                .email("test8@test.com")
                .password("Test123!@")
                .zipcode(12345)
                .address("서울시 강남구")
                .detailAddress("테헤란로 123")
                .loginMethod(true)
                .status(UserStatus.활성화)
                .notification(true)
                .registeredAt(LocalDateTime.now())
                .build();
        userRepository.save(user);

        Category category = categoryRepository.findById(1L).orElseThrow();

        UserCategoryId id = new UserCategoryId(user.getId(), category.getId());
        UserInterest userInterest = UserInterest.builder()
                .id(id)
                .user(user)
                .category(category)
                .build();

        // When
        UserInterest savedUserInterest = userInterestRepository.save(userInterest);

        log.info("UserInterest: " + savedUserInterest);
        // Then
//        assertThat(savedUserInterest.getId()).isEqualTo(id);
//        assertThat(savedUserInterest.getUser()).isEqualTo(user);
//        assertThat(savedUserInterest.getCategory()).isEqualTo(category);
    }

    @Test
    public void userEntityTest() {
        User user = User.builder()
                .name("테스트유저331")
                .nickname("테스트닉네임")
                .phone("010-1234-5678")
                .gender(true)
                .birth("19900101")
                .email("test5@test.com")
                .password("Test123!@")
                .zipcode(12345)
                .address("서울시 강남구")
                .detailAddress("테헤란로 123")
                .loginMethod(true)
                .status(UserStatus.활성화)
                .notification(true)
                .registeredAt(LocalDateTime.now())
                .build();

        User savedUser = userRepository.save(user);

        User foundUser = userRepository.findById(savedUser.getId())
                .orElseThrow(() -> new RuntimeException("왜 없지"));

        System.out.println("Saved User ID: " + savedUser.getId());
        System.out.println("Saved User Email: " + foundUser.getEmail());
    }

    @Test
    public void FindUserTest() {
        User user = userRepository.findById(1L).orElseThrow();
        log.info(user);
    }

    @Test
    public void FindManagerTest() {
        Manager manager = managerRepository.findById(1L).orElseThrow();
        log.info(manager);
    }

    @Test
    public void FindChatReportTest() {
        ChatReport chatReport = chatReportRepository.findById(1L).orElseThrow();
        log.info(chatReport);
    }

    @Test
    public void SaveChatReportTest() {
        User user = userRepository.findById(3L).orElseThrow();
        Project project = Project.builder().id(2L).build();
        Manager manager = managerRepository.findById(2L).orElseThrow();
        ChatReport chatReport = ChatReport.builder()
                .user(user)
                .project(project)
                .manager(manager)
                .reason("부적절한 채팅 내용1")
                .chatMessage("안녕하세요")
                .createdAt(LocalDateTime.now())
                .build();
        ChatReport savedChatReport = chatReportRepository.save(chatReport);
        log.info(savedChatReport);
    }

    @Test
    public void FindMakerTest() {
        Maker maker = makerRepository.findById(1L).orElseThrow();
        log.info(maker);
    }

    @Test
    public void SaveMakerTest() {
        Maker maker = Maker.builder()
                .name("테스트메이커")
                .phone("010-1234-5678")
                .business(123456)
                .email("aa@.com")
                .password("1234")
                .zipcode(12345)
                .address("서울시 강남구")
                .detailAddress("테헤란로 123")
                .registerStatus(0)
                .unregisteredAt(LocalDateTime.now())
                .registeredAt(LocalDateTime.now())
                .status(0)
                .build();
        Maker savedMaker = makerRepository.save(maker);
        log.info(savedMaker);
    }

    @Test
    public void FindScheduleTest() {
        Schedule schedule = scheduleRepository.findById(1L).orElseThrow();
        log.info(schedule);
    }

    @Test
    public void SaveScheduleTest() {
        Project project = Project.builder().id(1L).build();
        Schedule schedule = Schedule.builder()
                .project(project)
                .date(LocalDateTime.now())
                .build();
        Schedule savedSchedule = scheduleRepository.save(schedule);
        log.info(savedSchedule);
    }

    @Test
    public void FindScriptTest() {
        Script script = scriptRepository.findById(1L).orElseThrow();
        log.info(script);
    }

    @Test
    public void SaveScriptTest() {
        Schedule schedule = Schedule.builder().id(1L).build();
        Script script = Script.builder()
                .schedule(schedule)
                .scriptUrl("http://test.com")
                .build();
        Script savedScript = scriptRepository.save(script);
        log.info(savedScript);
    }

    @Test
    public void FindVideoTest() {
        Video video = videoRepository.findById(1L).orElseThrow();
        log.info(video);
    }

    @Test
    public void SaveVideoTest() {
        Schedule schedule = Schedule.builder().id(1L).build();
        Video video = Video.builder()
                .schedule(schedule)
                .mediaUrl("http://test.com")
                .build();
        Video savedVideo = videoRepository.save(video);
        log.info(savedVideo);
    }

    @Test
    public void FindEventTest() {
        Event event = eventRepository.findById(1L).orElseThrow();
        log.info(event);
    }

    @Test
    public void SaveEventTest() {
        Project project = Project.builder().id(1L).build();
        Event event = Event.builder()
                .project(project)
                .name("테스트이벤트")
                .content("테스트이벤트내용")
                .prize("테스트상품")
                .maxParticipants(100)
                .createdAt(LocalDateTime.now())
                .build();
        Event savedEvent = eventRepository.save(event);
        log.info(savedEvent);
    }

    @Test
    public void FindEventLogTest() {
        EventLog eventLog = EventLog.builder()
                .id(new EventLogId(1L, 1L))
                .event(Event.builder().id(1L).build())
                .user(User.builder().id(1L).build())
                .winningPrize("테스트상품")
                .winningData(LocalDateTime.now())
                .createdAt(LocalDateTime.now())
                .build();

        EventLog savedEventLog = eventLogRepository.save(eventLog);
        log.info(savedEventLog);

        List<EventLog> eventLogs = eventLogRepository.findAll();
        for (EventLog eventLog1 : eventLogs) {
            log.info(eventLog1);
        }
    }


}
