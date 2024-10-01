package com.workshop.repositories.Course;

import com.workshop.model.courseModel.Course;
import com.workshop.model.courseModel.CourseLocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface CourseLocationRepository extends JpaRepository<CourseLocation,Long> {

    List<CourseLocation> findCourseLocationsByCourses(Course course);
    CourseLocation findCourseLocationById(Long id);

    @Transactional
    @Modifying
    @Query("UPDATE CourseLocation c SET c.Area = :#{#courseLocation.area}, c.schedule_Date = :#{#courseLocation.schedule_Date} WHERE c.id = :Id")
    void updateCourseLocation(@Param("Id") Long Id, @Param("courseLocation") CourseLocation courseLocation);

    @Transactional
    @Modifying
    @Query("UPDATE CourseLocation cl SET cl.locations.id = :Location_Id WHERE cl.id = :CourseLocation_id")
    void updateLocationToLocationCourse(@Param("CourseLocation_id") Long CourseLocation_id, @Param("Location_Id") Long Location_Id);



}
