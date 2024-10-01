package com.workshop.service;

import com.workshop.dto.CourseDTO.CourseResponses;
import com.workshop.dto.useDTO.UserInfoResponse;



import com.workshop.model.userModel.User;

import com.workshop.model.userModel.User;



import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdminService {
    //----------------------------------------------------Account----------------------------------------------------//
    boolean chanceIsEnableWithRoleAndId(Long Id);
    boolean deleteAddressOfUser(Long userId,Long userAddressId);
    UserInfoResponse findUserById(Long userId);
    List<UserInfoResponse> listAccountByRole(String role);
    List<UserInfoResponse> listAccount();

    User getCurrentUserDetails();

    UserInfoResponse userDetail();
    //----------------------------------------------------Account----------------------------------------------------//
    //----------------------------------------------------Course----------------------------------------------------//
    List<CourseResponses> listCourse();

    //----------------------------------------------------Course----------------------------------------------------//

}
