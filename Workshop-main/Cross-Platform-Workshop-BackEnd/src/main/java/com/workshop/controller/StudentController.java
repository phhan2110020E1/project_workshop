package com.workshop.controller;

import com.workshop.config.ApiResponse;
import com.workshop.config.cloud.ResponseRequestOptions;
import com.workshop.dto.CourseDTO.CourseResponses;
import com.workshop.dto.LikeDTO;
import com.workshop.dto.RatingRequest;
import com.workshop.dto.RequestDTO.RequestDTO;
import com.workshop.dto.mobile.CourseResponsesMobi;
import com.workshop.dto.mobile.walletResponsesMobi;
import com.workshop.dto.useDTO.UserEditRequest;
import com.workshop.dto.useDTO.UserInfoResponse;
import com.workshop.dto.useDTO.favoriteDTO;
import com.workshop.event.SendQrCodeEvent;
import com.workshop.service.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user/")
@RequiredArgsConstructor
@SecurityRequirement(name ="bearerAuth")
@Tag(name = "Student Controller", description = "Quản Lý Tác Vụ Học Sinh")
public class StudentController {
    private final ApplicationEventPublisher publisher;
    private final UserService userService;
    private final RequestService requestService;
    private final CourseService courseService;
    private final TransactionService transactionService;
    private final RatingService ratingService;
    private final LikeService likeService;
    @PostMapping("/ratings")
    public ResponseEntity<ApiResponse> createRating(@RequestBody RatingRequest ratingRequest) {

        try {
            boolean result = ratingService.createOrUpdateRating(ratingRequest);
            if (result) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "Password has been changed", null));
            } else {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>("failure", "Password change failed", null));
            }
        } catch (Exception authException) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(authException.getMessage(), "Authentication service error", null));
        }
    }
    @GetMapping("/list-favorite")
    public ResponseEntity<ApiResponse> favoriteList() {

        try {
            List<favoriteDTO> favoriteList = ratingService.listFavorite();
            if (favoriteList !=null) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "list favoriteList", favoriteList));
            } else {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>("failure", "list favoriteList is empty", null));
            }
        } catch (Exception authException) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(authException.getMessage(), "Authentication service error", null));
        }
    }
    @Operation(summary = "Check User isLike workshop")
    @GetMapping("like/checkedUser")
        public ResponseEntity<ApiResponse<?>> checkUserIsLike(@RequestParam int course_id) {

        Long courseId = (long) course_id;
        try {
            boolean res = likeService.checkUserLike(courseId);
            if (res) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "success", res));
            } else {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("failure", "failure", false));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("failure", "failure", false));
        }
    }
    @Operation(summary = "Check User isLike mentor")
    @GetMapping("like/check-like-mentor")
    public ResponseEntity<ApiResponse<?>> checkUserIsLikeMentor(@RequestParam int teacher_id) {
        Long teacherId = (long) teacher_id;
        try {
            boolean res = likeService.checkUserLikeTeacher(teacherId);
            if (res) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "success", true));
            } else {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("failure", "failure", false));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("failure", "failure", false));
        }
    }
    @PostMapping("/like")
    public ResponseEntity<ApiResponse> like(@RequestBody LikeDTO likeDTO) {

        try {
            boolean result = likeService.createLike(likeDTO);
            if (result) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "success", true));
            } else {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("failure", "failure", false));
            }
        } catch (Exception authException) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(authException.getMessage(), "Authentication service error", null));
        }
    }
    @Operation(summary = "Lấy thông tin cá nhân Học Sinh")
    @GetMapping("/detail")
    public ResponseEntity<ApiResponse<?>> UserDetail() {
        UserInfoResponse userInfoResponse = userService.userDetail();
        if(userInfoResponse !=null){
            return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                    ("Success", "Your Info is ", userInfoResponse));
        }else{
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                    ("Success", "Your Info is ", null));
        }
    }
    @Operation(summary = "Đổi mật khẩu")
    @PutMapping("changePassword")
    public ResponseEntity<ApiResponse<?>> changePassword(@RequestParam String oldPassword, @RequestParam String newPassword) {
        try {
            boolean result = userService.ChangePassword(oldPassword, newPassword);
            if (result) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "Password has been changed", null));
            } else {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>("failure", "Password change failed", null));
            }
        } catch (Exception authException) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(authException.getMessage(), "Authentication service error", null));
        }
    }
    @Operation(summary = "Sửa thông tin Student")
    @PutMapping("/edit")
    public ResponseEntity<ApiResponse<?>> editUser(@RequestBody UserEditRequest userEditRequest) {
        try {
            boolean result = userService.EditUser(userEditRequest);
            if (result) {
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                        ("Success", "Your Info Has Been Changed", null));
            } else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ApiResponse<>
                        ("Error", "Please check again", null));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>
                    ("Error", "An error occurred: " + e.getMessage(), null));
        }
    }
    @Operation(summary = "Nạp Tiền Vào Tài Khoản")
    @PostMapping("/deposit")
    public ResponseEntity<ApiResponse<?>> Deposit(@RequestBody RequestDTO requestDTO) {
        try {
            requestDTO.setType("DEPOSIT");
            ResponseRequestOptions responseRequestOptions =  requestService.createRequestOptions(requestDTO);
            if (responseRequestOptions.getStatus().equals("APPROVED")) {
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                        ("Success", "Your Request APPROVED", null));
            } else if(responseRequestOptions.getStatus().equals("PENDING") ){
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>
                        ("pending", "Your Request PENDING", null));
            }else{
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                        ("cancel", "Your Request REJECTED", null));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>
                    ("Error", "An error occurred: " + e.getMessage(), null));
        }
    }
    @Operation(summary = "Mua khóa Học")
    @PostMapping("/byCourse")
    public ResponseEntity<ApiResponse<?>> ByCourse(@RequestBody RequestDTO requestDTO) {
        try {
            requestDTO.setType("BUY_COURSE");
            ResponseRequestOptions responseRequestOptions =  requestService.createRequestOptions(requestDTO);
            publisher.publishEvent((new SendQrCodeEvent(
                    responseRequestOptions.getUser_name(),
                    responseRequestOptions.getEmail(),
                    responseRequestOptions.getUrlQrCode(),
                    responseRequestOptions.getWorkshopName()
            )));
            if (responseRequestOptions.getStatus().equals("APPROVED")) {
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                        ("Success", "Your Request ACCEPTED", null));
            } else if(responseRequestOptions.getStatus().equals("PENDING") ){
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>
                        ("pending", "Your Request PENDING", null));
            }else{
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                        ("cancel", "Your Request REJECTED", null));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>
                    ("Error", "An error occurred: " + e.getMessage(), null));
        }
    }
    @Operation(summary = "Check Code Course Discount")
    @GetMapping("/checkDiscount")
    public ResponseEntity<ApiResponse<?>> CheckCodeDiscountCourese(@RequestParam int courseId,@RequestParam String code){
        try {
            int result =  courseService.checkCodeDiscount((long) courseId,code);
            if (result>0) {
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                        ("Success", "Your Code is Active", result));
            } else if(result==0) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>
                        ("Success", "Your Code : "+code+ " is OutDate or Not Available", null));
            }else if(result==-1){
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ApiResponse<>
                        ("Error", "Your Code : "+code+ " not Found", null));
            }else{
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ApiResponse<>
                        ("Error", "Your Code : "+code+ " not Found", null));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>
                    ("Error", "An error occurred: " + e.getMessage(), null));
        }
    }

    @Operation(summary = "Danh Sách WorkShop chưa diễn ra Của Học Sinh ")
    @GetMapping("course/list")
    public ResponseEntity<ApiResponse<?>> listWorkShopInComingUp() {
        try {
            List<CourseResponsesMobi> listCourse = courseService.listCourseStudentById();
            System.out.print(listCourse);
            return ResponseEntity.status(HttpStatus.OK)
                    .body(new ApiResponse<>("success", "List of Courses", listCourse));
        } catch (RuntimeException exception) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>("error", exception.getMessage(), null));
        }
    }
    @Operation(summary = "Danh Sách WorkShop đã đăng kí Của Học Sinh ")
    @GetMapping("course/detail")
    public ResponseEntity<ApiResponse<?>> listWorkshopStudent() {
        try {
            List<CourseResponses> listCourse = courseService.listWorkshopStudent();
            System.out.print(listCourse);
            return ResponseEntity.status(HttpStatus.OK)
                    .body(new ApiResponse<>("success", "List of Courses", listCourse));
        } catch (RuntimeException exception) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>("error", exception.getMessage(), null));
        }
    }
    @Operation(summary = "Thông tin Ví tiền ")
    @GetMapping("wallet")
    public ResponseEntity<ApiResponse<?>> detailWallet() {
        try {
            walletResponsesMobi walletResponsesMobi = transactionService.walletResponsesMobi();
            return ResponseEntity.status(HttpStatus.OK)
                    .body(new ApiResponse<>("success", "walletResponsesMobi", walletResponsesMobi));
        } catch (RuntimeException exception) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>("error", exception.getMessage(), null));
        }
    }
}