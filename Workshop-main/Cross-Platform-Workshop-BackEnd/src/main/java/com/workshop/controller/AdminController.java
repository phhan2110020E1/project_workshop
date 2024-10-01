package com.workshop.controller;

import com.workshop.config.ApiResponse;
import com.workshop.config.cloud.ResponseRequestOptions;
import com.workshop.dto.*;
import com.workshop.dto.CourseDTO.CourseResponses;
import com.workshop.dto.DashBoardDTO.DashboardDTO;
import com.workshop.dto.DashBoardDTO.WeeklyRecapDTo;
import com.workshop.dto.RequestDTO.RequestDTO;
import com.workshop.dto.useDTO.UserEditRequest;
import com.workshop.dto.useDTO.UserInfoResponse;
import com.workshop.model.Transaction;
import com.workshop.service.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/admin/")
@RequiredArgsConstructor
@Tag(name = "Admin Area Controller", description = "Quản Lý Tác Vụ Admin Service")
@SecurityRequirement(name = "bearerAuth")
public class AdminController {

    private final AdminService adminService;
    private final CourseService courseService;
    private final RequestService requestService;
    private final UserService userService;
    private final LocationService locationService;
    private final DashboardService dashboardService;
    private final TransactionService transactionService;
    private final RatingService ratingService;

    private ResponseEntity<ApiResponse<?>> createResponse(HttpStatus httpStatus, String status, String message, Object data) {
        return ResponseEntity.status(httpStatus).body(new ApiResponse<>(status, message, data));
    }

    @GetMapping("/rating/list")
    public ResponseEntity<ApiResponse<?>> findAllRatingsWithDetails() {
        try {
            List<adminListRatingDTO> listRating = ratingService.findAllRatingsWithDetails();
            if (listRating.isEmpty()) {
                return createResponse(HttpStatus.ACCEPTED, "Not Found", "List listRating is empty", null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "List of listRating", listRating);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Thay đổi trạng thái Comment")
    @PutMapping("comment/status")
    public ResponseEntity<ApiResponse<?>> changeStatusRating(@RequestParam int id) {
        try {
            Long longId = (long) id;
            if (longId >0) {
                boolean result = ratingService.settingStatusComment(longId);
                if (result) {
                    return createResponse(HttpStatus.ACCEPTED, "success", "The comment Status has been changed", null);
                } else {
                    return createResponse(HttpStatus.BAD_REQUEST, "error", "Failed to comment course status", null);
                }
            } else {
                return createResponse(HttpStatus.NO_CONTENT, "error", "Invalid request: comment ID is missing", null);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "DashBoard")
    @GetMapping("DashBoard")
    public ResponseEntity<ApiResponse<?>> DashBoard() {
        try {
            DashboardDTO dtos = dashboardService.Dashboard();
            if (dtos==null) {
                return createResponse(HttpStatus.ACCEPTED, "error", "DashBoard is empty", null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "get DashBoard success", dtos);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Week Recap")
    @GetMapping("WeekRecap")
    public ResponseEntity<ApiResponse<?>> WeekRecap() {
        try {
            List<WeeklyRecapDTo> dtos = dashboardService.WEEKLY_RECAP_D_TO_LIST();
            if (dtos==null) {
                return createResponse(HttpStatus.ACCEPTED, "error", "WeeklyRecap is empty", null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "get WeeklyRecap success", dtos);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Xét duyệt rút tiền về cho giáo viên")
    @GetMapping("teacher/withdraw")
    public ResponseEntity<ApiResponse<?>> handleWithDrawRequest(@RequestParam int teacher_id,@RequestParam int request_id) {
        try {
            RequestDTO requestDTO = new RequestDTO();
            requestDTO.setRequestId((long) request_id);
            requestDTO.setItem_register_id((long) teacher_id);
            requestDTO.setType("WITHDRAW");
            ResponseRequestOptions responseRequestOptions  =  requestService.createRequestOptions(requestDTO);
            if (responseRequestOptions.getStatus().equals("APPROVED")) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>
                        ("Success", "Request is APPROVED", null));
            } else if(responseRequestOptions.getStatus().equals("REJECTED") ){
                return ResponseEntity.status(HttpStatus.CONTINUE).body(new ApiResponse<>
                        ("rejected", "Request is REJECTED", null));
            }else{
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                        ("cancel", "Request is CANCEL", null));
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Danh Sách Workshop")
    @GetMapping("course/list")
    public ResponseEntity<ApiResponse<?>> listCourse() {
        try {
            List<CourseResponses> courses = adminService.listCourse();
            if (courses.isEmpty()) {
                return createResponse(HttpStatus.NOT_FOUND, "error", "List Courses is empty", null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "List of courses", courses);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Danh Sách listTransaction")
    @GetMapping("transaction/list")
    public ResponseEntity<ApiResponse<?>> listTransactionDTO() {
        try {
            List<TransactionDTO> transactionDTOS = transactionService.TRANSACTION_DTO_LIST();
            if (transactionDTOS.isEmpty()) {
                return createResponse(HttpStatus.NOT_FOUND, "error", "List transactionList is empty", null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "List of transactionList", transactionDTOS);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Danh Sách Location")
    @GetMapping("location/list")
    public ResponseEntity<ApiResponse<?>> listLocation() {
        try {
            List<LocationDTO> location = locationService.listLocation();
            if (location.isEmpty()) {
                return createResponse(HttpStatus.NOT_FOUND, "error", "List location is empty", null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "List of location", location);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Danh Sách Request")
    @GetMapping("request/list")
    public ResponseEntity<ApiResponse<?>> listRequest() {
        try {
            List<RequestResponse> requestResponseList = requestService.ListRequest();
            if (requestResponseList.isEmpty()) {
                return createResponse(HttpStatus.ACCEPTED, "success", "List Request is empty", null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "List of Request", requestResponseList);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Thay đổi trạng thái Course")
    @PutMapping("course/status")
    public ResponseEntity<ApiResponse<?>> activeCourse(@RequestParam int id) {
        try {
            Long longId = (long) id;
            if (longId >0) {
                boolean result = courseService.settingStatusCourse(longId);
                if (result) {
                    return createResponse(HttpStatus.ACCEPTED, "success", "The Course Status has been changed", null);
                } else {
                    return createResponse(HttpStatus.BAD_REQUEST, "error", "Failed to change course status", null);
                }
            } else {
                return createResponse(HttpStatus.NO_CONTENT, "error", "Invalid request: Course ID is missing", null);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Cập Nhật Location vào Course_Location")
    @PutMapping("course/locationUpdate")
    public ResponseEntity<ApiResponse<?>> locationUpdate(@RequestParam int course_location_Id,@RequestParam int location_id) {
        try {
            Long CourseLocationId = (long) course_location_Id;
            Long LocationId = (long) location_id;
            if (CourseLocationId >0 && LocationId>0) {
                boolean result = courseService.UpdateLocationToLocationCourse(CourseLocationId,LocationId);
                if (result) {
                    return createResponse(HttpStatus.ACCEPTED, "success", "The Location has been Add Success", null);
                } else {
                    return createResponse(HttpStatus.BAD_REQUEST, "error", "Failed to Add Location ", null);
                }
            } else {
                return createResponse(HttpStatus.NO_CONTENT, "error", "Invalid request: CourseLocationId is missing", null);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Tìm Account bằng Role")
    @GetMapping("user/listUserByRole")
    public ResponseEntity<ApiResponse<?>> listAccountByRole(@RequestParam(name = "role") String role) {
        try {
            List<UserInfoResponse> accounts = adminService.listAccountByRole(role);
            if (accounts.isEmpty()) {
                return createResponse(HttpStatus.NOT_FOUND, "error", "No account found with role " + role, null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "List of " + role, accounts);
            }
        }catch(Exception e){
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Tìm Account bằng Id")
    @GetMapping("user/findById")
    public ResponseEntity<ApiResponse<?>> AccountById(@RequestParam(name = "id") int id) {
        try {
            Long longId = (long) id;
           UserInfoResponse accounts = adminService.findUserById(longId);
            if (accounts!=null) {
                return createResponse(HttpStatus.ACCEPTED, "success", "User by :" + id, accounts);
            } else {
                return createResponse(HttpStatus.NOT_FOUND, "error", "No account found with Id " + id, null);
            }
        }catch(Exception e){
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Danh sách Account")
    @GetMapping("user/listUser")
    public ResponseEntity<ApiResponse<?>> listAccount() {
        try {
            List<UserInfoResponse> accounts = adminService.listAccount();
            if (accounts.isEmpty()) {
                return createResponse(HttpStatus.NOT_FOUND, "error", "No account found with role " , null);
            } else {
                return createResponse(HttpStatus.ACCEPTED, "success", "List of " , accounts);
            }
        }catch(Exception e){
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }
    @Operation(summary = "Thay đổi trạng thái Account")
    @PostMapping("user/changeStatus")
    public ResponseEntity<ApiResponse<?>> activeUserByRole(@RequestParam int id) {
        try {
            Long longId = (long) id;
            boolean result = adminService.chanceIsEnableWithRoleAndId(longId);
            if (result) {
                return createResponse(HttpStatus.ACCEPTED, "success", "Account Status has been Chance", null);
            } else {
                return createResponse(HttpStatus.BAD_REQUEST, "error", "Failed to activate teacher", null);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", e.getMessage(), null);
        }
    }
    @Operation(summary = "Sửa thông tin cá nhân Admin")
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
    @Operation(summary = "Lấy thông tin cá nhân Admin")
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

    @Operation(summary = "Thay đổi trạng thái Request")
    @PutMapping("request/status")
    public ResponseEntity<ApiResponse<?>> activeRequest(@RequestParam int id) {
        try {
            Long longId = (long) id;
            if (longId >0) {
                boolean result = requestService.changeStatusRequest(longId);
                if (result) {
                    return createResponse(HttpStatus.ACCEPTED, "success", "The Course Status has been changed", null);
                } else {
                    return createResponse(HttpStatus.BAD_REQUEST, "error", "Failed to change course status", null);
                }
            } else {
                return createResponse(HttpStatus.NO_CONTENT, "error", "Invalid request: Course ID is missing", null);
            }
        } catch (Exception e) {
            return createResponse(HttpStatus.INTERNAL_SERVER_ERROR, "error", "Internal Server Error", null);
        }
    }

}

