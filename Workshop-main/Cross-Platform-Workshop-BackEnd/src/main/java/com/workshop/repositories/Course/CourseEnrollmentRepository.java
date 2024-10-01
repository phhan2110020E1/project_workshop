package com.workshop.repositories.Course;

import com.workshop.model.courseModel.Course;
import com.workshop.model.courseModel.CourseEnrollment;
import com.workshop.model.userModel.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CourseEnrollmentRepository extends JpaRepository<CourseEnrollment,Long> {

    CourseEnrollment findByCoursesAndEnrolledStudent(Course course, User user);


    @Query("SELECT COUNT(c) > 0 FROM CourseEnrollment c WHERE c.enrolledStudent.id = :user_id AND c.courses.id = :course_id")
    boolean checkUserInCourse(@Param("user_id") Long user_id, @Param("course_id") Long course_id);

    @Query("SELECT ce.courses FROM CourseEnrollment ce WHERE ce.enrolledStudent = :student")
    List<Course> findWorkshopByStudent(@Param("student") User student);
    @Query("SELECT ce.courses FROM CourseEnrollment ce JOIN ce.courses courses WHERE ce.enrolledStudent = :student AND courses.isPublic = true")
    List<Course> findEnrolledCoursesByStudent(@Param("student") User student);

    @Query("SELECT COUNT(ce) FROM CourseEnrollment ce WHERE ce.courses = :course")
    long countEnrollmentsByCourse(@Param("course") Course course);
}
