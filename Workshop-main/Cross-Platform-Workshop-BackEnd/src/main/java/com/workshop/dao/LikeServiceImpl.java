package com.workshop.dao;
import com.workshop.dto.LikeDTO;
import com.workshop.dto.TeacherRatingDTO;
import com.workshop.model.Like;
import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import com.workshop.repositories.Course.CourseRepository;
import com.workshop.repositories.User.LikeRepository;
import com.workshop.repositories.User.UserRepository;
import com.workshop.service.LikeService;
import com.workshop.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.function.Supplier;

@Service
@RequiredArgsConstructor
public class LikeServiceImpl implements LikeService
{
    private final LikeRepository likeRepository;
    private final UserService userService;
    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    @Override
    public Boolean createLike(LikeDTO likeDTO) {
        try {
            User user = userService.getCurrentUserDetails();
            Course course = courseRepository.findCourseById(likeDTO.getWorkshopId());
            Optional<User> teacher = userRepository.findById(likeDTO.getTeacherId());
            if ("TEACHER".equals(likeDTO.getTargetType())) {
                if (teacher.isPresent()) {
                    Optional<Like> existingLike = likeRepository.findByUserIdAndTeacherIdAndTargetType(user.getId(), likeDTO.getTeacherId(),likeDTO.getTargetType());
                    return processLike(existingLike, () -> new Like().setUser(user).setTeacher(teacher.get()).setWorkshop(course).setTargetType("TEACHER"));
                }
            } else if ("WORKSHOP".equals(likeDTO.getTargetType())) {

                Optional<Like> existingLike = likeRepository.findByUserIdAndWorkshopIdAndTargetType(user.getId(), likeDTO.getWorkshopId(),likeDTO.getTargetType());
                return processLike(existingLike, () -> new Like().setUser(user).setWorkshop(course).setTeacher(teacher.get()).setTargetType("WORKSHOP"));
            }

            return false;
        } catch (Exception exception) {
            return false;
        }
    }
    private Boolean processLike(Optional<Like> existingLike, Supplier<Like> likeSupplier) {
        if (existingLike.isPresent()) {
            likeRepository.delete(existingLike.get());
        } else {
            likeRepository.save(likeSupplier.get());
        }
        return true;
    }
    @Override
    public List<TeacherRatingDTO> getTopTeachersByLikes()
    {
        return likeRepository.findTeachersSortedByLikes();
    }
    boolean isCourse(Long Id) {
        Course course_exit = courseRepository.findCourseById(Id);
        return course_exit != null;
    }
    @Override
    public boolean checkUserLike(Long workshopId) {
        User userEdx = userService.getCurrentUserDetails();
        try{
            boolean result = isCourse(workshopId);
            Long user_id = userEdx.getId();
            if(result){
                return likeRepository.checkUserLike(user_id,workshopId);
            }else{
                return false;
            }
        }catch (Exception e)
        {
           throw e;
        }
    }

    @Override
    public boolean checkUserLikeTeacher(Long teacherId) {
        User userEdx = userService.getCurrentUserDetails();
        try{
            Long user_id = userEdx.getId();
            return likeRepository.checkUserLikeMentor(user_id,teacherId);
        }catch (Exception e)
        {
            throw e;
        }
    }
}
