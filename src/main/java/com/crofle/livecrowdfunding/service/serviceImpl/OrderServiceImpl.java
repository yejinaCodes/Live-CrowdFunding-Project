package com.crofle.livecrowdfunding.service.serviceImpl;

import com.crofle.livecrowdfunding.domain.entity.Orders;
import com.crofle.livecrowdfunding.domain.entity.Project;
import com.crofle.livecrowdfunding.domain.entity.User;
import com.crofle.livecrowdfunding.dto.request.OrderRequestDTO;
import com.crofle.livecrowdfunding.dto.response.OrderResponseDTO;
import com.crofle.livecrowdfunding.repository.OrdersRepository;
import com.crofle.livecrowdfunding.repository.ProjectRepository;
import com.crofle.livecrowdfunding.repository.UserRepository;
import com.crofle.livecrowdfunding.service.OrderService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StopWatch;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OrderServiceImpl implements OrderService {

    private final UserRepository userRepository;
    private final ProjectRepository projectRepository;
    private final OrdersRepository ordersRepository;
    private final ModelMapper modelMapper;


    @Override
    @Transactional
    public OrderResponseDTO createOrder(OrderRequestDTO orderRequestDTO) {
        StopWatch stopWatch = new StopWatch();
        stopWatch.start();

        User user = findUser(orderRequestDTO.getId());
        Project project = findProject(orderRequestDTO.getId());
        int paymentPrice = calculatePaymentPrice(orderRequestDTO.getAmount(), project.getPrice());

        Orders savedOrder = Orders.builder().
                user(user).
                project(project).
                amount(orderRequestDTO.getAmount()).
                paymentPrice(paymentPrice).
                build();

        savedOrder = ordersRepository.save(savedOrder);

        OrderResponseDTO orderResponseDTO = modelMapper.map(savedOrder, OrderResponseDTO.class);
        stopWatch.stop();
        log.info("********************주문 생성 시 걸린 시간: {} ********************", stopWatch.getTotalTimeSeconds());
        return orderResponseDTO;
    }

    private User findUser(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("사용자를 찾을 수 없습니다. ID: " + userId));
    }

    private Project findProject(Long projectId) {
        return projectRepository.findById(projectId)
                .orElseThrow(() -> new EntityNotFoundException("프로젝트를 찾을 수 없습니다. ID: " + projectId));
    }

    private int calculatePaymentPrice(int amount, int projectPrice) {
        if (amount <= 0) {
            throw new IllegalArgumentException("수량은 0보다 커야 합니다.");
        }
        return amount * projectPrice;
    }
}
