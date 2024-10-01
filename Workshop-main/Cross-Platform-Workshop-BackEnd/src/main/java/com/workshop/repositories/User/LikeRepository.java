package com.workshop.repositories.User;

import com.workshop.dto.TeacherRatingDTO;
import com.workshop.model.Like;
import com.workshop.model.userModel.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LikeRepository extends JpaRepository<Like,Long> {
    @Query("SELECT COUNT(l) > 0 FROM Like l WHERE l.workshop.id = :course_id AND l.user.id = :user_id AND l.targetType ='WORKSHOP'")
    boolean checkUserLike(@Param("user_id") Long user_id, @Param("course_id") Long course_id);
    @Query("SELECT COUNT(l) > 0 FROM Like l WHERE l.teacher.id = :teacher_id AND l.user.id = :user_id AND l.targetType ='TEACHER'")
    boolean checkUserLikeMentor(@Param("user_id") Long user_id, @Param("teacher_id") Long teacher_id);
    Optional<Like> findByUserIdAndTeacherIdAndTargetType(Long userId, Long teacherId,String targetType);
    Optional<Like> findByUserIdAndWorkshopIdAndTargetType(Long userId,Long workshopId,String targetType);
    @Query("SELECT new com.workshop.dto.TeacherRatingDTO(" +
            "u.id, " +
            "u.full_name, " +
            "u.user_name, " +
            "u.email, " +
            "u.phoneNumber, " +
            "u.image_url, " +
            "u.gender, " +
            "COUNT(l)) " +
            "FROM Like l JOIN l.teacher u " +
            "GROUP BY u.id, u.full_name, u.user_name, u.email, u.phoneNumber, u.image_url, u.gender " +
            "ORDER BY COUNT(l) DESC")
    List<TeacherRatingDTO> findTeachersSortedByLikes();

}
