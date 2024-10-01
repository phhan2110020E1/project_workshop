package com.workshop.repositories.Course;
import com.workshop.model.courseModel.*;
import com.workshop.model.userModel.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface CourseRepository extends JpaRepository<Course,Long>
{
    Course findCourseById(Long id);
    @Modifying
    @Query("SELECT ce.enrolledStudent FROM CourseEnrollment ce WHERE ce.courses.id = :courseId")
    List<User> listUserInCourse(@Param("courseId") long courseId);
    @Transactional
    @Modifying
    @Query(" insert into CourseEnrollment (courses, enrolledStudent) " +
            "SELECT c, u FROM Course c JOIN User u ON u.id IN :studentIds " +
            "WHERE c.id = :courseId" )
    void addStudentToCourseEnroll(@Param("courseId") long courseId, @Param("studentIds") Long studentIds);
    @Modifying
    @Query("SELECT c FROM Course c WHERE c.teacher.id = :teacherId")
    List<Course> listCoursebyTeacherId(Long teacherId);
    @Modifying
    @Query("SELECT c FROM Course c WHERE c.isPublic = true")
    List<Course> listCoursePublic();
    @Query("SELECT c FROM Course c WHERE c.isPublic = true  and c.id = :courseId")
    Course CoursePublic(@Param("courseId") long courseId);
    @Transactional
    @Modifying
    @Query("UPDATE Course c SET c.name = :#{#course.name}, c.description = :#{#course.description}" +
            ", c.price = :#{#course.price}, c.startDate = :#{#course.startDate}, c.endDate = :#{#course.endDate}" +
            ", c.type = :#{#course.type},c.student_count = :#{#course.student_count} WHERE c.id = :Id")
    void updateCourse(@Param("Id") Long Id, @Param("course") Course course);
    @Transactional
    @Modifying
    @Query("UPDATE Course c SET c.isPublic = CASE WHEN c.isPublic = true THEN false ELSE true END WHERE c.id = :id")
    int chanceStatusCourseById(Long id);
    @Query("SELECT c FROM Course c WHERE c.createdDate >= :startOfMonth AND c.createdDate <= :endOfMonth")
    List<Course> getCoursesCreatedBetween(@Param("startOfMonth") LocalDateTime startOfMonth, @Param("endOfMonth") LocalDateTime endOfMonth);

}
