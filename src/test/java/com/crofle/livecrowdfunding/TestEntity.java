package com.crofle.livecrowdfunding;

import com.crofle.livecrowdfunding.domain.entity.*;
import com.crofle.livecrowdfunding.domain.enums.PaymentMethod;
import com.crofle.livecrowdfunding.domain.enums.ProjectStatus;
import com.crofle.livecrowdfunding.domain.enums.UserStatus;
import com.crofle.livecrowdfunding.repository.*;
import org.aspectj.weaver.ast.Or;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;

import java.time.LocalDateTime;

@SpringBootTest
@Rollback(false)
public class TestEntity {

    @Autowired
    private MakerRepository makerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RatePlanRepository ratePlanRepository;

    @Autowired
    private ManagerRepository managerRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ImageRepository imageRepository;

    @Autowired
    private EssentialDocumentRepository essentialDocumentRepository;

    @Autowired
    private LikedRepository likedRepository;

    @Autowired
    private OrdersRepository ordersRepository;

    @Autowired
    private PaymentHistoryRepository paymentHistoryRepository;

    @Autowired
    private TopFundingRepository topFundingRepository;


    @Test
    public void ratePlanTest(){
        RatePlan ratePlanAdd = RatePlan.builder().planName("Ultimate").charge(Boolean.TRUE).build();
        RatePlan savePlan = ratePlanRepository.save(ratePlanAdd);
        RatePlan findPlan = ratePlanRepository.findById(savePlan.getId())
                .orElseThrow( ()-> new RuntimeException("Not present"));
        System.out.println(savePlan.getId());
        System.out.println(findPlan.getPlanName() + " price: " + findPlan.getCharge());
    }

    @Test
    public void projectTest() {

        //Maker
        Maker maker = Maker.builder().name("yejina").phone("010-1234-5678").business(12318282)
                .email("test4@test.com").password("Test123!@").zipcode(12345).address("서울시 강남구").detailAddress("테헤란로 123")
                .registeredAt(LocalDateTime.now()).registerStatus(0).status(0).build();
        Maker savedMaker = makerRepository.save(maker);
        Maker foundMaker = makerRepository.findById(savedMaker.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Saved Maker ID: " + savedMaker.getId());
        System.out.println("Saved Maker Email: " + foundMaker.getEmail());


        //Manager
        Manager manager = Manager.builder().name("Kimbab").email("kimbab@gmail.com").password("12345").identificationNumber("12345678910111213141")
                .phone("010-1234-5678").registeredAt(LocalDateTime.now()).build();
        Manager savedManager = managerRepository.save(manager);
        Manager foundManager = managerRepository.findById(savedManager.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Saved Manager ID: " + savedManager.getId());
        System.out.println("Saved Manager Email: " + foundManager.getEmail());


        //RatePlan
        RatePlan ratePlanAdd = RatePlan.builder().planName("Ultimate").charge(Boolean.TRUE).build();
        RatePlan savePlan = ratePlanRepository.save(ratePlanAdd);
        RatePlan findPlan = ratePlanRepository.findById(savePlan.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("요금제 타입: " + savePlan.getId());
        System.out.println("요금제명: " + findPlan.getPlanName() + " price: " + findPlan.getCharge());


        //Category 임의로 넣기
        Category category = Category.builder().classification("전자기기").build();
        Category saveCategory = categoryRepository.save(category);
        Category findCategory = categoryRepository.findById(saveCategory.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Category Id: " + saveCategory.getId());
        System.out.println("category type: " + findCategory.getClassification());

        //Project
        Project project = Project.builder().maker(savedMaker).manager(savedManager).ratePlan(savePlan).category(saveCategory)
                .productName("히터양말").summary("겨울필수템").price(200000).discountPercentage(10).startAt(LocalDateTime.now())
                .endAt(LocalDateTime.now().plusMonths(1)).percentage(5).reviewProjectStatus(ProjectStatus.승인).progressProjectStatus(ProjectStatus.펀딩중)
                .goalAmount(10000000).contentImage("http://hereshouldbecontentimage").build();
        Project saveProject = projectRepository.save(project);
        Project findProject = projectRepository.findById(saveProject.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Project Id: " + saveProject.getId());
        System.out.println("Project 이름: " + findProject.getProductName() + " Project price: " + findProject.getPrice() + "Project 펀딩률% " + findProject.getPercentage());


        //EssentialDocument
        EssentialDocument doc = EssentialDocument.builder().project(saveProject).document("https://wheredocissaved").build();
        EssentialDocument savedDoc = essentialDocumentRepository.save(doc);
        EssentialDocument findDoc = essentialDocumentRepository.findById(savedDoc.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Doc Id: " + savedDoc.getId());
        System.out.println("Doc projectID: " + findDoc.getProject().getId() + " Doc loc: " + findDoc.getDocument());


        //Image
        Image image = Image.builder().project(saveProject).image("https://whereimageissaved").build();
        Image savedImage = imageRepository.save(image);
        Image findImage = imageRepository.findById(savedImage.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Image Id: " + savedImage.getId());
        System.out.println("Image projectID: " + findImage.getProject().getId() + " Image loc: " + findImage.getImage());

        //TopFunding
        TopFunding topFunding = TopFunding.builder().project(saveProject).ranking(1).updatedAt(LocalDateTime.now()).build();
        TopFunding savedFunding = topFundingRepository.save(topFunding);
        TopFunding findFunding = topFundingRepository.findById(savedFunding.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Topfunding Id: " + savedFunding.getId());
        System.out.println("Topfunding projectID: " + findFunding.getProject().getId() + " TopFunding Ranking: " + findFunding.getRanking());


        //Order
        User user = User.builder().name("hojin").nickname("hojingogo").phone("010-1234-5678").gender(true).birth("19900101")
                .email("test8@test.com").password("Test123!@").zipcode(12345).address("서울시 강남구").detailAddress("테헤란로 123")
                .loginMethod(true).status(UserStatus.활성화).notification(true).registeredAt(LocalDateTime.now()).build();
        User savedUser = userRepository.save(user);

        Orders order = Orders.builder().user(savedUser).project(saveProject).amount(5).paymentPrice(100000).build();
        Orders savedOrder = ordersRepository.save(order);
        Orders findOrder = ordersRepository.findById(savedOrder.getId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Order Id: " + savedOrder.getId());
        System.out.println("Order UserId: " + findOrder.getUser().getId() + " Order ProjectId: " + findOrder.getProject().getId() + " amount, price: " + findOrder.getAmount() + findOrder.getPaymentPrice());

        //PaymentHistory
        PaymentHistory payHistory = PaymentHistory.builder().order(savedOrder).paymentMethod(PaymentMethod.카드)
                .deliveryAddress("서울 강남구").paymentAt(LocalDateTime.now()).refundStatus(0).build();
        PaymentHistory savedPayment = paymentHistoryRepository.save(payHistory);
        PaymentHistory findPayment = paymentHistoryRepository.findById(savedPayment.getOrderId())
                .orElseThrow(() -> new RuntimeException("Not present"));
        System.out.println("Payment Id: " + savedPayment.getOrderId());
        System.out.println("Payment method: " + findPayment.getPaymentMethod() + " Payment date: " + findPayment.getPaymentAt() + " Payment delivery address: " + findPayment.getDeliveryAddress());


//        //Liked
//        Liked liked = Liked.builder().id(1).build();


    }

    }
