package com.workshop.repositories.Course;

import com.workshop.model.Discount;
import com.workshop.model.courseModel.CourseDiscount;
import com.workshop.model.courseModel.CourseEnrollment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseDiscountRepository extends JpaRepository<CourseDiscount,Long> {

    @Transactional
    @Modifying
    @Query("UPDATE CourseDiscount cd SET cd.status = :newStatus WHERE cd.id = :discountId")
    void updateCourseDiscountStatus(@Param("discountId") Long discountId, @Param("newStatus") CourseDiscount.Status newStatus);

    @Query("SELECT cd FROM CourseDiscount cd WHERE cd.course.id = :courseId AND cd.status = :status")
    List<CourseDiscount> findDiscountsByCourseIdAndStatus(
            @Param("courseId") Long courseId,
            @Param("status") CourseDiscount.Status status
    );

    @Transactional
    void deleteByCode(String Code);

    CourseDiscount findByCode(String code);

    @Query("SELECT cd FROM CourseDiscount cd WHERE cd.course.id = :courseId AND cd.code = :code")
    CourseDiscount findDiscountsByCourseIdAndCode( @Param("courseId") Long courseId, @Param("code") String code);
}
