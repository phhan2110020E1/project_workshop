package com.workshop.repositories;

import com.workshop.dto.HomePageListRatingDTO;
import com.workshop.dto.TeacherRatingDTO;
import com.workshop.dto.WorkshopRatingDTO;
import com.workshop.dto.adminListRatingDTO;
import com.workshop.dto.useDTO.favoriteDTO;
import com.workshop.model.Rating;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RatingRepository extends JpaRepository<Rating,Long> {
    Optional<Rating> findByUserIdAndTeacherId(Long userId, Long teacherId);
    Optional<Rating> findByUserIdAndWorkshopId(Long userId, Long workshopId);
    @Transactional
    @Modifying
    @Query("UPDATE Rating r SET r.rating = :rating, r.comment = :comment WHERE r.id = :id")
    void updateRating(Long id, Double rating, String comment);

@Query("SELECT new com.workshop.dto.TeacherRatingDTO(" +
        "u.id, " +
        "r.targetType, " +
        "u.full_name, " +
        "u.user_name, " +
        "u.email, " +
        "u.phoneNumber, " +
        "u.image_url, " +
        "u.gender, " +
        "AVG(r.rating), " +
        "COUNT(r.id)) " +
        "FROM User u " +
        "JOIN Rating r ON u.id = r.teacher.id " +
        "WHERE r.status = true AND r.targetType = 'MENTOR' " +
        "GROUP BY u.id,r.targetType, u.full_name, u.user_name, u.email, u.phoneNumber, u.image_url, u.gender " +
        "ORDER BY AVG(r.rating) DESC")
List<TeacherRatingDTO> findTeachersSortedByAverageRating();


    @Query("SELECT new com.workshop.dto.WorkshopRatingDTO(" +
            "w.id, " +
            "(SELECT r.targetType FROM Rating r WHERE r.workshop.id = w.id and r.targetType = 'WORKSHOP'), " +
            "w.name, " +
            "(SELECT ci.urlImage FROM CourseMediaInfo ci WHERE ci.course.id = w.id AND ci.id = (SELECT MIN(subCi.id) FROM CourseMediaInfo subCi WHERE subCi.course.id = w.id)), " +
            "t.id, " +
            "t.full_name, " +
            "t.image_url, " +
            "(SELECT AVG(r.rating) FROM Rating r WHERE r.workshop.id = w.id ) AS avgRating, " +
            "w.price) " +
            "FROM Course w " +
            "JOIN w.teacher t " +
            "GROUP BY w.id, w.name, t.full_name, t.image_url, w.price " +
            "ORDER BY avgRating DESC")
    List<WorkshopRatingDTO> findAllWorkshopsWithRatingsSortedByRating();

//    @Query("SELECT new com.workshop.dto.adminListRatingDTO(" +
//            "r.targetType,"+
//            "r.id,"+
//            "w.id, " + // workshop_id
//            "m.id, " + // mentor_id
//            "w.name, " + // workshop_name
//            "m.full_name, " +
//            "(SELECT ci.urlImage FROM CourseMediaInfo ci WHERE ci.course.id = w.id ORDER BY ci.id ASC LIMIT 1), "+
//            "m.image_url," +
//
//            "r.rating, " +
//            "r.comment, " +
//            "r.status) " +
//            "FROM Rating r " +
//            "JOIN r.workshop w " +
//            "JOIN r.user m")
//    List<adminListRatingDTO> findAllRatingsWithDetails();
@Query("SELECT new com.workshop.dto.adminListRatingDTO(" +
        "r.targetType, " +
        "r.id, " + // rating_id
        "w.id, " + // workshop_id
        "t.id, " + // mentor_id
        "w.name, " + // workshop_name
        "t.full_name, " + // mentor_name
        "(SELECT ci.urlImage FROM CourseMediaInfo ci WHERE ci.course.id = w.id ORDER BY ci.id ASC LIMIT 1), " + // workshop_img
        "t.image_url, " + // mentor_img
        "u.full_name, " + // user_comment_name
        "u.id, " + // user_comment_id
        "u.image_url, " + // user_comment_img
        "r.rating, " +
        "r.comment, " +
        "r.status) " +
        "FROM Rating r " +
        "JOIN r.workshop w " +
        "JOIN r.teacher t " +
        "JOIN r.user u") // user who made the comment
List<adminListRatingDTO> findAllRatingsWithDetails();
//    @Query("SELECT new com.workshop.dto.HomePageListRatingDTO(" +
////            "r.targetType, " +
////            "r.id, " + // rating_id
////            "w.id, " + // workshop_id
////            "t.id, " + // mentor_id
////            "w.name, " + // workshop_name
////            "t.full_name, " + // mentor_name
////            "(SELECT ci.urlImage FROM CourseMediaInfo ci WHERE ci.course.id = w.id ORDER BY ci.id ASC LIMIT 1), " + // workshop_img
////            "t.image_url, " + // mentor_img
////            "u.full_name, " + // user_comment_name
////            "u.id, " + // user_comment_id
////            "u.image_url, " + // user_comment_img
////            "r.rating, " +
////            "r.comment, " +
////            "r.status) " +
////            "FROM Rating r " +
////            "JOIN r.workshop w " +
////            "JOIN r.teacher t " +
////            "JOIN r.user u " +
////            "WHERE r.status = true "
////    ) // user who made the comment
////    List<HomePageListRatingDTO> findAllRatingsWithDetailsPublic();
@Query("SELECT new com.workshop.dto.HomePageListRatingDTO(" +
        "r.targetType, " +
        "r.id, " + // rating_id
        "w.id, " + // workshop_id
        "t.id, " + // teacher_id
        "w.name, " + // workshop_name
        "t.full_name, " + // teacher_name
        "(SELECT ci.urlImage FROM CourseMediaInfo ci WHERE ci.course.id = w.id ORDER BY ci.id ASC LIMIT 1), " + // workshop_img
        "t.image_url, " + // teacher_img
        "u.full_name, " + // user_comment_name
        "u.id, " + // user_comment_id
        "u.image_url, " + // user_comment_img
        "r.rating, " +
        "r.comment, " +
        "r.status) " +
        "FROM Rating r " +
        "JOIN r.workshop w " +
        "JOIN r.teacher t " +
        "JOIN r.user u " +
        "WHERE r.status = true AND w.id = :courseId AND t.id = :teacherId")
List<HomePageListRatingDTO> findAllRatingsByCourseIdAndTeacherId(@Param("courseId") Long courseId, @Param("teacherId") Long teacherId);



    @Transactional
    @Modifying
    @Query("UPDATE Rating c SET c.status = CASE WHEN c.status = true THEN false ELSE true END WHERE c.id = :id")
    int chanceStatusRatingById(Long id);


    @Query("SELECT new com.workshop.dto.useDTO.favoriteDTO(" +
            "l.id, " +
            "l.targetType, " +
            "t.id, " +

            "t.full_name, " +
            "COALESCE(t.image_url,'DefaultImageUrl'), " +
            "COALESCE((SELECT AVG(r2.rating) FROM Rating r2 WHERE r2.teacher = t),0.0), " +
            "COALESCE((SELECT COUNT(l1) FROM Like l1 WHERE l1.teacher = t and l1.targetType = 'TEACHER'),0) , " +
            "COALESCE(w.id,0), " +

            "COALESCE(w.name,'DefaultName'), " +
            "COALESCE((SELECT c.urlImage FROM CourseMediaInfo c WHERE c.course = w AND c IS NOT NULL ORDER BY c.id ASC LIMIT 1),'DefaultImageUrl'), " +
            "COALESCE((SELECT AVG(r3.rating) FROM Rating r3 WHERE r3.workshop = w),0.0), " +
            "COALESCE((SELECT COUNT(l2) FROM Like l2 WHERE l2.workshop = w and l2.targetType = 'WORKSHOP'),0) " +
            ") " +
            "FROM Like l " +
            "LEFT JOIN l.teacher t " +
            "LEFT JOIN l.workshop w " +
            "WHERE l.user.id = :userId " +
            "GROUP BY l.id, t.id, w.id")
    List<favoriteDTO> findFavoritesByUserId(Long userId);








}
