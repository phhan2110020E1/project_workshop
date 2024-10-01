package com.workshop.controller;

import com.workshop.config.ApiResponse;
import com.workshop.config.cloud.ResponseRequestOptions;
import com.workshop.dto.CourseDTO.CourseRequest;
import com.workshop.dto.CourseDTO.CourseResponses;
import com.workshop.dto.CourseDTO.CourseUpdateRequest;
import com.workshop.dto.RequestDTO.RequestDTO;
import com.workshop.dto.mobile.QrResponsesMobi;
import com.workshop.dto.useDTO.UserEditRequest;
import com.workshop.dto.useDTO.UserInfoResponse;
import com.workshop.service.CourseService;
import com.workshop.service.RequestService;
import com.workshop.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/seller/")
@RequiredArgsConstructor
@SecurityRequirement(name = "bearerAuth")
@Tag(name = "Teacher Controller", description = "Quản Lý Tác Vụ Giáo Viên")
public class TeacherController {
    private final CourseService courseService;
    private final UserService userService;
    private final RequestService requestService;
    @Operation(summary = "Đổi mật khẩu")
    @PutMapping("chancePassword")
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

    @Operation(summary = "Lấy thông tin cá nhân Teacher")
    @GetMapping("/detail")
    public ResponseEntity<ApiResponse<?>> UserDetail() {
        UserInfoResponse userInfoResponse = userService.userDetail();
        if (userInfoResponse != null) {
            return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                    ("Success", "Your Info is ", userInfoResponse));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                    ("Success", "Your Info is ", null));
        }
    }

    @Operation(summary = "Sửa thông tin cá nhân Teacher")
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

    @Operation(summary = "Xóa Address")
    @DeleteMapping("/deleteAddress/{useAddress_id}")
    public ResponseEntity<ApiResponse<?>> deleteUserAddress(@PathVariable Long useAddress_id) {
        try {
            boolean result = userService.DeleteAddress(useAddress_id);
            if (result) {
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                        ("Success", "Delete Success", null));
            } else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ApiResponse<>
                        ("Error", "Please check again", null));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>
                    ("Error", "An error occurred: " + e.getMessage(), null));
        }
    }

    @Operation(summary = "Danh Sách Học Sinh Trong Khóa Học")
    @GetMapping("/course/listStudent/{id}")
    public ResponseEntity<ApiResponse<?>> ListStudentByCourser(@PathVariable Long id) {
        try {
            List<UserInfoResponse> ListStudent = courseService.listStudentByCourse(id);
            if (ListStudent != null && !ListStudent.isEmpty()) {
                return ResponseEntity.status(HttpStatus.OK)
                        .body(new ApiResponse<>("success", "List of Students", ListStudent));
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(new ApiResponse<>("error", "No Students Found", null));
            }
        } catch (Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("error", "An error occurred while listing students", null));
        }

    }

    @Operation(summary = "Gửi Yêu Cầu Rút Tiền Về Tài Khoản")
    @PostMapping("/deposit")
    public ResponseEntity<ApiResponse<?>> WithDraw(@RequestBody RequestDTO requestDTO) {
        try {
            requestDTO.setType("HANDLE_WITHDRAW");
            ResponseRequestOptions responseRequestOptions = requestService.createRequestOptions(requestDTO);
            if (responseRequestOptions.getStatus().equals("PENDING")) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>
                        ("Success", "Your Request PENDING", null));
            } else if (responseRequestOptions.getStatus().equals("REJECTED")) {
                return ResponseEntity.status(HttpStatus.CONTINUE).body(new ApiResponse<>
                        ("pending", "Your Balance Not Enable", null));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                        ("cancel", "Your Request REJECTED", null));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>
                    ("Error", "An error occurred: " + e.getMessage(), null));
        }
    }

    @Operation(summary = "Danh Sách Khóa Học Của Giáo Viên")
    @GetMapping("course/list")
    public ResponseEntity<ApiResponse<?>> ListCourseByTeacher() {
        try {
            List<CourseResponses> ListCourse = courseService.listCourseTeacher();
            System.out.print(ListCourse);
            return ResponseEntity.status(HttpStatus.OK)
                    .body(new ApiResponse<>("success", "List of ListCourse", ListCourse));
        } catch (RuntimeException exception) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>("error", exception.getMessage(), null));
        }
    }

    @Operation(summary = "Danh Sách Khóa Học Của Giáo Viên Theo Id")
    @GetMapping("course/list/{id}")
    public ResponseEntity<ApiResponse<?>> listCourseByTeacherId(@RequestParam Long courseId) {
        try {
            List<CourseResponses> listCourse = courseService.listCourseTeacherById(courseId);
            System.out.print(listCourse);
            return ResponseEntity.status(HttpStatus.OK)
                    .body(new ApiResponse<>("success", "List of Courses", listCourse));
        } catch (RuntimeException exception) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>("error", exception.getMessage(), null));
        }
    }

    @Operation(summary = "Thêm khóa Học")
    @PostMapping("course/add")
    public ResponseEntity<ApiResponse<?>> AddCourse(@RequestBody CourseRequest courseRequest) {
        if (courseRequest != null) {
            boolean result = courseService.addCourse(courseRequest);
            if (result) {
                return ResponseEntity.status(HttpStatus.CREATED)
                        .body(new ApiResponse<>(HttpStatus.CREATED.name(), "The Course has been Create ", null));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                        ("error", "The Course cant been Create", null));
            }
        } else {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>
                    ("error", "The Course NO_CONTENT", null));
        }
    }

    @Operation(summary = "Sửa khóa Học")
    @PutMapping("course/update/{id}")
    public ResponseEntity<ApiResponse<?>> UpdateCourse(@PathVariable Long id, @RequestBody CourseUpdateRequest courseUpdateRequest) {
        if (id != null && courseUpdateRequest != null) {
            boolean result = courseService.updateCourse(id, courseUpdateRequest);
            if (result) {
                return ResponseEntity.status(HttpStatus.CREATED)
                        .body(new ApiResponse<>(HttpStatus.CREATED.name(), "The Course has been Update ", null));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                        ("error", "The Course cant been Update", courseUpdateRequest));
            }
        } else {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>
                    ("error", "The Course NO_CONTENT", null));
        }
    }

    @Operation(summary = "Xóa khóa Học")
    @DeleteMapping("course/delete/{id}")
    public ResponseEntity<ApiResponse<?>> deleteCourse(@PathVariable Long id) {
        if (id != null) {
            boolean result = courseService.deleteCourse(id);
            if (result) {
                return ResponseEntity.status(HttpStatus.ACCEPTED)
                        .body(new ApiResponse<>(HttpStatus.ACCEPTED.name(), "The Course has been Delete ", null));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>
                        ("error", "The Course cant been Delete", null));
            }
        } else {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(new ApiResponse<>
                    ("error", "The Course NO_CONTENT", null));
        }
    }
    @Operation(summary = "Gửi ngẩu Nhiên Discount Workshop kế tiếp cho list Student")
    @PostMapping("course/addListStudent/{id}/")
    public ResponseEntity<ApiResponse<?>> SendDiscountToListStudent(@PathVariable Long id, @RequestBody List<Long> studentIds) {
        try {
            boolean result = courseService.addDiscountToStudent(id, studentIds);
            if (result) {
                return ResponseEntity.status(HttpStatus.CREATED)
                        .body(new ApiResponse<>("success", "List of Students has been added to the Course", result));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(new ApiResponse<>("error", "No Students Found", result));
            }
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>("error", ex.getMessage(), studentIds));
        } catch (Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ApiResponse<>("error", "An error occurred while adding students to the course", null));
        }
    }
    @Operation(summary = "Check checkTicket Workshop")
    @GetMapping("/checkTicket")
    public ResponseEntity<ApiResponse<?>> CheckQrTicket(@RequestParam int userId,@RequestParam int workshopId){
        try {
            QrResponsesMobi qrResponsesMobi =  courseService.checkQrTicker((long) userId,(long) workshopId);
            if (Objects.equals(qrResponsesMobi.getStatus(), "valid")) {
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                        ("Success", "Your Ticket is valid", qrResponsesMobi));
            } else if(Objects.equals(qrResponsesMobi.getStatus(), "outdated")) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>
                        ("Success", "Your Ticket is outdated", qrResponsesMobi));
            }else{
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ApiResponse<>
                        ("Error", "Your Ticket is not validation", qrResponsesMobi));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>
                    ("Error", "An error occurred: " + e.getMessage(), null));
        }
    }

}

