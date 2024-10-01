package com.workshop.dao;
import com.workshop.dto.DashBoardDTO.DashboardDTO;
import com.workshop.dto.DashBoardDTO.WeeklyRecapDTo;
import com.workshop.model.Request;
import com.workshop.model.Transaction;
import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import com.workshop.model.userModel.UserBanking;
import com.workshop.repositories.Course.CourseRepository;
import com.workshop.repositories.DiscountRepository;
import com.workshop.repositories.RequestRepository;
import com.workshop.repositories.TransactionRepository;
import com.workshop.repositories.User.UserBankRepository;
import com.workshop.repositories.User.UserRepository;
import com.workshop.service.DashboardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.util.Comparator;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.DayOfWeek;
import java.time.LocalDateTime;

import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.*;

@Service
@Slf4j
@RequiredArgsConstructor
public class DashBoardServiceImpl implements DashboardService {
    private final CourseRepository courseRepository;
    private final TransactionRepository transactionRepository;
    private final UserRepository userRepository;
    private final DiscountRepository discountRepository;
    private final UserBankRepository userBankRepository;
    private final RequestRepository requestRepository;

    @Override
    public DashboardDTO Dashboard() {
        try {
            DashboardDTO Dashboard = new DashboardDTO();

            LocalDateTime startOfMonth = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth());
            LocalDateTime endOfMonth = LocalDateTime.now().with(TemporalAdjusters.lastDayOfMonth());

            LocalDateTime startOfLastMonth = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth()).minusMonths(1);
            LocalDateTime endOfLastMonth = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth()).minusDays(1);

            DecimalFormat df = new DecimalFormat("#.####");

            List<User> totalAccount = userRepository.findAll();
            List<User> totalUser = userRepository.countUsersWithUserRole();
            List<User> totalTeacher = userRepository.countUsersWithSellerRole();
//
            List<User> newUserThisMonth = userRepository.getUsersCreatedBetween(startOfMonth,endOfMonth);
            List<User> newUserLastMonth = userRepository.getUsersCreatedBetween(startOfLastMonth,endOfLastMonth);
            int checkLechSoLuongUser = (int) (newUserThisMonth.size() - newUserLastMonth.size());
            double phanTramThayDoisoluongUser = 0.0;
            if (!newUserLastMonth.isEmpty()) {
                phanTramThayDoisoluongUser = ((double) checkLechSoLuongUser / Math.abs(newUserLastMonth.size())) * 100;
            }
            phanTramThayDoisoluongUser = Double.parseDouble(df.format(phanTramThayDoisoluongUser));

            List<User> newTeacherThisMonth = userRepository.getUsersWithRolesAndRoleCreatedBetween(startOfMonth,endOfMonth,"SELLER");
            List<User> newStudentThisMonth = userRepository.getUsersWithRolesAndRoleCreatedBetween(startOfMonth,endOfMonth,"USER");

            List<User> newStudentThisYear = totalUser.stream().filter(user -> user.getCreatedDate().toLocalDateTime().isAfter(LocalDateTime.now().minusYears(1))).toList();
            List<User> newTeacherThisYear = totalTeacher.stream().filter(user -> user.getCreatedDate().toLocalDateTime().isAfter(LocalDateTime.now().minusYears(1))).toList();

            List<Course> courseResponsesList = courseRepository.findAll();
            List<Course> newCoursesThisMonth = courseRepository.getCoursesCreatedBetween(startOfMonth,endOfMonth);
            List<Course> newCoursesLastMonth =  courseRepository.getCoursesCreatedBetween(startOfLastMonth,endOfLastMonth);
            List<Course> newCoursesThisYear= courseResponsesList.stream().filter(course -> course.getCreatedDate().toLocalDateTime().isAfter(LocalDateTime.now().minusMonths(1))).toList();

            int checkLechSoLuongCourse = (int) (newCoursesThisMonth.size() - newCoursesLastMonth.size());
            double phanTramThayDoisoluongCourse = 0.0;
            if (!newCoursesLastMonth.isEmpty()) {
                phanTramThayDoisoluongCourse = ((double) checkLechSoLuongCourse / Math.abs(newCoursesLastMonth.size())) * 100;
            }
            phanTramThayDoisoluongCourse = Double.parseDouble(df.format(phanTramThayDoisoluongCourse));

            long transactionList = transactionRepository.findAll().size();
            long successfulTransactions = transactionRepository.countSuccessfulTransactions();
            long FailedTransactions = transactionRepository.countFailedTransactions();


            long TotalRevenue = transactionRepository.getTotalAmountOfCompletedBuyCourseTransactions();
            long CoursesRevenueThisMonth = transactionRepository.getTotalAmountOfCompletedBuyCourseTransactionsInMount(startOfMonth,endOfMonth);
            long CoursesRevenueLastMonth = transactionRepository.getTotalAmountOfCompletedBuyCourseTransactionsInMount(startOfLastMonth, endOfLastMonth);
            int checkLechDoanhThu = (int) (CoursesRevenueThisMonth - CoursesRevenueLastMonth);
            double phanTramThayDoi = 0.0;
            if (CoursesRevenueLastMonth != 0) {
                phanTramThayDoi = ((double) checkLechDoanhThu / Math.abs(CoursesRevenueLastMonth)) * 100;
            }

            phanTramThayDoi = Double.parseDouble(df.format(phanTramThayDoi));

            List<UserBanking> userBankings = userBankRepository.findAll();
            Dashboard
                    //account//
                    .setTotalAccount(totalAccount.size())
                    .setTotalTeacher(totalTeacher.size()).setNewTeacherThisMonth(newTeacherThisMonth.size()).setNewTeacherThisYear(newTeacherThisYear.size())
                    .setTotalStudent(totalUser.size()).setNewStudentThisMonth(newStudentThisMonth.size()).setNewStudentThisYear(newStudentThisYear.size())
                    .setRatioUser(phanTramThayDoisoluongUser)
                    //account//

                    //course//
                    .setTotalCourses(courseResponsesList.size()).setNewCoursesThisMonth(newCoursesThisMonth.size()).setNewCoursesThisYear(newCoursesThisYear.size())
                    .setRatioCourse(phanTramThayDoisoluongCourse)
                    //course//

                    //Revenue//
                    .setTotalCoursesPricing((int) TotalRevenue).setCoursesPricingThisMonth((int) CoursesRevenueThisMonth)
                    .setTotalRevenue((int) ((int) TotalRevenue*0.03)).setRevenueThisMonth((int) CoursesRevenueThisMonth*0.03)
                    .setRatioRevenue(phanTramThayDoi)
                    //Revenue//

                    .setTotalDiscounts(discountRepository.findAll().size())
                    .setTotalBankAccounts(userBankings.size())

                    .setTotalTransactions((int) transactionList)


                    .setSuccessfulTransactions((int) successfulTransactions);

            return Dashboard;
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public List<WeeklyRecapDTo> WEEKLY_RECAP_D_TO_LIST() {
        List<WeeklyRecapDTo> weeklyRecapList = new ArrayList<>();
        LocalDateTime startOfWeek = LocalDateTime.now().with(TemporalAdjusters.previous(DayOfWeek.MONDAY)).truncatedTo(ChronoUnit.DAYS);
        LocalDateTime endOfWeek = LocalDateTime.now().with(LocalTime.MAX);
        List<Transaction> transactionList = transactionRepository.findByCreatedDateBetween(
                Timestamp.valueOf(startOfWeek),
                Timestamp.valueOf(endOfWeek)
        );
        List<Request> requestsLists = requestRepository.findByCreatedDateBetween(
                Timestamp.valueOf(startOfWeek),
                Timestamp.valueOf(endOfWeek)
        );
        Map<Integer, List<Transaction>> transactionsByDayOfWeek = groupTransactionsByDayOfWeek(transactionList);
        Map<Integer, List<Request>> requestByDayOfWeek = groupRequestByDayOfWeek(requestsLists);

        for (Map.Entry<Integer, List<Request>> entry : requestByDayOfWeek.entrySet()) {
            int dayOfWeek = entry.getKey();
            List<Request> RequestForDay = entry.getValue();
            int totalAPPROVED = calculateTotalRequestByStatus(RequestForDay, Request.RequestStatus.APPROVED);
            int totalPENDING = calculateTotalRequestByStatus(RequestForDay, Request.RequestStatus.PENDING);
            int totalCANCEL = calculateTotalRequestByStatus(RequestForDay, Request.RequestStatus.CANCEL);
            Optional<WeeklyRecapDTo> existingDay = weeklyRecapList.stream()
                    .filter(dto -> getDayName(dayOfWeek).equals(dto.getNameOfDay()))
                    .findFirst();
            if (existingDay.isEmpty()) {
                WeeklyRecapDTo weeklyRecapDTo = new WeeklyRecapDTo();
                weeklyRecapDTo.setRequestApproved(totalAPPROVED);
                weeklyRecapDTo.setRequestPending(totalPENDING);
                weeklyRecapDTo.setRequestCancel(totalCANCEL);

                weeklyRecapDTo.setNameOfDay(getDayName(dayOfWeek));
                weeklyRecapList.add(weeklyRecapDTo);
            } else {
                WeeklyRecapDTo existingDto = existingDay.get();
                existingDto.setRequestApproved(existingDto.getRequestApproved() + totalAPPROVED);
                existingDto.setRequestPending(existingDto.getRequestPending()+totalPENDING);
                existingDto.setRequestCancel(existingDto.getRequestCancel()+totalCANCEL);

            }
        }
        for (Map.Entry<Integer, List<Transaction>> entry : transactionsByDayOfWeek.entrySet()) {
            int dayOfWeek = entry.getKey();
            List<Transaction> transactionsForDay = entry.getValue();
            int totalDeposit = calculateTotalTransactionSuccessByType(transactionsForDay, Transaction.Type.DEPOSIT);
            int totalWithdraw = calculateTotalTransactionSuccessByType(transactionsForDay, Transaction.Type.WITHDRAW);
            int totalityWorship = calculateTotalTransactionSuccessByType(transactionsForDay, Transaction.Type.BUY_COURSE);

            Optional<WeeklyRecapDTo> existingDay = weeklyRecapList.stream()
                    .filter(dto -> getDayName(dayOfWeek).equals(dto.getNameOfDay()))
                    .findFirst();

            if (existingDay.isEmpty()) {
                WeeklyRecapDTo weeklyRecapDTo = new WeeklyRecapDTo();
                weeklyRecapDTo.setTransactionDeposit(totalDeposit);
                weeklyRecapDTo.setTransactionWithdraw(totalWithdraw);
                weeklyRecapDTo.setTransactionByWorkshop(totalityWorship);

                weeklyRecapDTo.setNameOfDay(getDayName(dayOfWeek));
                weeklyRecapList.add(weeklyRecapDTo);
            } else {
                WeeklyRecapDTo existingDto = existingDay.get();
                existingDto.setTransactionDeposit(existingDto.getTransactionDeposit() + totalDeposit);
                existingDto.setTransactionWithdraw(existingDto.getTransactionWithdraw()+totalWithdraw);
                existingDto.setTransactionByWorkshop(existingDto.getTransactionByWorkshop()+totalityWorship);

            }
        }
        weeklyRecapList.sort(Comparator.comparingInt(dto -> getDayOfWeekValue(dto.getNameOfDay())));
        return weeklyRecapList;
    }
    private int calculateTotalTransactionSuccessByType(List<Transaction> transactions, Transaction.Type  transactionType) {
        return transactions.stream().filter(transaction ->
                        transactionType.equals(transaction.getType()) &&
                                transaction.getAmount() >0
                )
                .mapToInt(transaction -> (int) transaction.getAmount())
                .sum();
    }
    private int calculateTotalRequestByStatus(List<Request> requests, Request.RequestStatus  requestStatus) {
        return (int) requests.stream().filter(request ->
                        requestStatus.equals(request.getStatus())
                ).count();
    }
    private Map<Integer, List<Transaction>> groupTransactionsByDayOfWeek(List<Transaction> transactions) {
        Map<Integer, List<Transaction>> transactionsByDayOfWeek = new HashMap<>();
        for (Transaction transaction : transactions) {
            LocalDateTime transactionDateTime = transaction.getCreatedDate().toLocalDateTime();
            int dayOfWeek = transactionDateTime.getDayOfWeek().getValue();
            transactionsByDayOfWeek
                    .computeIfAbsent(dayOfWeek, k -> new ArrayList<>())
                    .add(transaction);
        }

        // Sort the lists within the map by day of the week
        transactionsByDayOfWeek.forEach((key, value) ->
                value.sort(Comparator.comparing(transaction ->
                        transaction.getCreatedDate().toLocalDateTime().toLocalTime())
                )
        );

        return transactionsByDayOfWeek;
    }
    private Map<Integer, List<Request>> groupRequestByDayOfWeek(List<Request> requests) {
        Map<Integer, List<Request>> requestByDayOfWeek = new HashMap<>();
        for (Request request : requests) {
            LocalDateTime requestDateTime = request.getCreatedDate().toLocalDateTime();
            int dayOfWeek = requestDateTime.getDayOfWeek().getValue();
            requestByDayOfWeek
                    .computeIfAbsent(dayOfWeek, k -> new ArrayList<>())
                    .add(request);
        }
        requestByDayOfWeek.forEach((key, value) ->
                value.sort(Comparator.comparing(request ->
                        request.getCreatedDate().toLocalDateTime().toLocalTime())
                )
        );
        return requestByDayOfWeek;
    }

    private String getDayName(int dayOfWeek) {
        switch (dayOfWeek) {
            case 1:
                return "Monday";
            case 2:
                return "Tuesday";
            case 3:
                return "Wednesday";
            case 4:
                return "Thursday";
            case 5:
                return "Friday";
            case 6:
                return "Saturday";
            case 7:
                return "Sunday";
            default:
                return "";
        }
    }
    private int getDayOfWeekValue(String dayOfWeek) {
        switch (dayOfWeek) {
            case "Monday":
                return 1;
            case "Tuesday":
                return 2;
            case "Wednesday":
                return 3;
            case "Thursday":
                return 4;
            case "Friday":
                return 5;
            case "Saturday":
                return 6;
            default:
                throw new IllegalArgumentException("Invalid day of the week: " + dayOfWeek);
        }
    }


}
