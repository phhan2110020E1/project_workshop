package com.workshop.service;

import com.workshop.authentication.OAuthenticationRequest;
import com.workshop.dto.useDTO.UserEditRequest;
import com.workshop.dto.useDTO.UserInfoResponse;
import com.workshop.dto.useDTO.UserRegisterRequest;
import com.workshop.model.userModel.Roles;
import com.workshop.model.userModel.User;
import org.springframework.stereotype.Repository;

@Repository
public interface UserService {
    User SaveUser(UserRegisterRequest user);
    Boolean EditUser(UserEditRequest user);
    User SaveUserOAuthed(OAuthenticationRequest OAuth);
    void SaveRoles(Roles role);
    boolean DeleteAddress(Long useAddress_id);
    boolean DeleteBank(Long useBank_id);
    User getCurrentUserDetails();
    void saveUserVerificationToken(User user, String verificationToken);
    String validate(String token);
    String ResetPasswordByMail(String mail);
    boolean ChangePassword(String oldPassword,String newPassword);
    UserInfoResponse userDetail();
}
