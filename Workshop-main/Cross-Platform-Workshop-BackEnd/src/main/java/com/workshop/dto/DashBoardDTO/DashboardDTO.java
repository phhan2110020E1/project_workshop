package com.workshop.dto.DashBoardDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.NumberFormat;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class DashboardDTO {

    //Account//
    @NumberFormat(pattern = "#,##0.00")
    private double totalAccount = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double totalStudent = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double newStudentThisMonth = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double newStudentThisYear = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double totalTeacher = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double newTeacherThisMonth = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double newTeacherThisYear = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double ratioUser = 0;
    //Account//

    //Course//
    @NumberFormat(pattern = "#,##0.00")
    private double totalCourses = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double newCoursesThisMonth = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double newCoursesThisYear = 0;
    @NumberFormat(pattern = "#,##0.00")
    private double ratioCourse = 0;
    //Course//
    //Revenue//
    @NumberFormat(pattern = "#,##0.00")
    private double totalRevenue = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double RevenueThisMonth = 0 ; /* Doanh thu trong tháng này */;
    @NumberFormat(pattern = "#,##0.00")
    private double totalCoursesPricing = 0 ;
    @NumberFormat(pattern = "#,##0.00")
    private double CoursesPricingThisMonth = 0 ; /* Doanh thu trong tháng này */;

    @NumberFormat(pattern = "#,##0.00")
    private double ratioRevenue = 0;
    //Revenue//

    @NumberFormat(pattern = "#,##0.00")
    private double totalDiscounts = 0 ; /* Tổng số lượng mã giảm giá từ cơ sở dữ liệu */;
    @NumberFormat(pattern = "#,##0.00")
    private double totalTransactions = 0 ; /* Tổng số lượng giao dịch từ cơ sở dữ liệu */;
    @NumberFormat(pattern = "#,##0.00")
    private double successfulTransactions = 0 ;/* Số lượng giao dịch thành công */;
    @NumberFormat(pattern = "#,##0.00")
    private double totalBankAccounts = 0 ;






}
