package com.workshop.controller;

import com.workshop.authentication.*;
import com.workshop.config.ApiResponse;
import com.workshop.dao.UserServiceImpl;
import com.workshop.dto.useDTO.UserEditRequest;
import com.workshop.dto.useDTO.UserRegisterRequest;
import com.workshop.event.RegisterCompleteEvent;
import com.workshop.event.RenewPasswordEvent;
import com.workshop.model.userModel.*;
import com.workshop.repositories.VerificationTokenRepository;
import com.workshop.service.AuthenticationService;
import com.workshop.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Tag(name = "Authentication Controller", description = "Quản Lý xác thực tài khoản")
public class AuthenticationController {
    private final AuthenticationService authenticationService;
    private final UserService userService;
    private final ApplicationEventPublisher publisher;
    private final VerificationTokenRepository verificationTokenRepository;

    private String applicationUrl(HttpServletRequest request) {
        return "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
    }
    @Operation(summary = "Đăng nhập bằng tài khoản Web")
    @PostMapping("/loginWeb")
    public ResponseEntity<ApiResponse<?>> webAuthentication(@RequestBody AuthenticationRequest authenticationRequest) {
        try {
            AuthenticationResponse<?> response = authenticationService.authenticationResponse(authenticationRequest);
            if (response != null) {
                return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "The data has been retrieved successfully", response));
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ApiResponse<>("error", "User not found", null));
            }
        } catch (Exception authException) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(authException.getMessage(), "Authentication service error", null));
        }
    }

    @Operation(summary = "Đăng nhập bằng tài khoản bên thứ ba")
    @PostMapping("/loginOAuthentication")
    public ResponseEntity<ApiResponse<?>> OAuthentication(@RequestBody OAuthenticationRequest OAuthen) {
        try {
            User user = userService.SaveUserOAuthed(OAuthen);
            if (user != null) {
                AuthenticationRequest authenticationRequest = new AuthenticationRequest();
                authenticationRequest.setPassword(user.getEmail()).setEmail(user.getEmail());
                try {
                    AuthenticationResponse<?> response = authenticationService.authenticationResponse(authenticationRequest);
                    if (response != null) {
                        return ResponseEntity.status(HttpStatus.OK).body(new ApiResponse<>("success", "The data has been retrieved successfully", response));
                    } else {
                        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ApiResponse<>("error", "User not found", null));
                    }
                } catch (Exception authException) {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(authException.getMessage(), "Authentication service error", null));
                }
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ApiResponse<>("error", "User not found", null));
            }
        } catch (Exception userException) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(userException.getMessage(), "User service error", null));
        }
    }

    @Operation(summary = "Đăng ký User bằng Role")
    @PostMapping("user/register")
    public ResponseEntity<ApiResponse<?>> registerUser(@RequestBody UserRegisterRequest userRegisterRequest, final HttpServletRequest request) {
       try {
           if (userRegisterRequest != null) {
               User user = userService.SaveUser(userRegisterRequest);
               publisher.publishEvent(new RegisterCompleteEvent(user, applicationUrl(request)));
               return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                       ("Success", "please check your Email to complete your registration", null));
           } else {
               return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ApiResponse<>
                       ("Error", "please check your Email Again", null));
           }
       }catch (UserServiceImpl.UserAlreadyExistsException ex) {
           // Handle user already exists
           return ResponseEntity.status(HttpStatus.FOUND).body(new ApiResponse<>
                   ("failed", ex.getMessage(), null));
       } catch (Exception e) {
           // Handle other exceptions
           return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ApiResponse<>
                   ("failed",HttpStatus.BAD_REQUEST.toString(), null));
       }
    }

    @Operation(summary = "Sửa thông tin User")
    @PutMapping("user/edit")
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

    @Operation(summary = "Lấy lại Mật Khẩu qua Mail")
    @PostMapping("user/forgetPassword")
    public ResponseEntity<ApiResponse<?>> webAuthentication(@RequestParam String Email, final HttpServletRequest request) {
        try {
            if (Email != null) {
                String newPassword = userService.ResetPasswordByMail(Email);
                publisher.publishEvent((new RenewPasswordEvent(Email, newPassword, applicationUrl(request))));
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new ApiResponse<>
                        ("Success", "please check your Email Get New Password", null));
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ApiResponse<>("error", "User not found", null));
            }
        } catch (Exception authException) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ApiResponse<>(authException.getMessage(), "Authentication service error", null));
        }
    }

    @Operation(summary = "Xác thực Register bằng Mail")
    @GetMapping("verifyEmail")
    public String verifyEmail(@RequestParam("token") String token) {
        VerificationToken byToken = verificationTokenRepository.findByToken(token);
        if (byToken.getUser().isEnable()) {
            return "This Account has already been verified,please ! Login";
        }
        String verification = userService.validate(token);
        if (verification.equalsIgnoreCase("valid")) {
            return "Email verified Successfully, You can login";
        }
        return "Invalid verification token";
    }

}