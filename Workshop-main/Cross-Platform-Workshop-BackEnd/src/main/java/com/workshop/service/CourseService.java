package com.workshop.service;

import com.workshop.dto.CourseDTO.CourseRequest;
import com.workshop.dto.CourseDTO.CourseResponses;
import com.workshop.dto.CourseDTO.CourseUpdateRequest;
import com.workshop.dto.mobile.CourseResponsesMobi;
import com.workshop.dto.mobile.QrResponsesMobi;
import com.workshop.dto.useDTO.UserInfoResponse;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseService {
    boolean addCourse(CourseRequest courseRequest);
    boolean updateCourse(Long id, CourseUpdateRequest courseRequest);
    boolean deleteCourse(Long id);
    boolean settingStatusCourse(Long id);
    List<UserInfoResponse> listStudentByCourse(Long id);
    List<CourseResponses> listCourseTeacher();
    boolean addDiscountToStudent(Long Course_id,List<Long> List_Student_id);
    List<CourseResponses> listCourseTeacherById(Long id);
    List<CourseResponsesMobi> listCourseStudentById();
    //Layer Website
    List<CourseResponses> listWorkshopEnable();
    List<CourseResponses> listWorkshopStudent();
    int checkCodeDiscount(Long CourseId,String discountCode);
    CourseResponses courseById(Long id);
    boolean checkUserInCourse(String email,Long course_id);
    boolean UpdateLocationToLocationCourse(Long CourseLocation_id,Long Location_Id );
    QrResponsesMobi checkQrTicker(Long userId, Long workshopId);

}
