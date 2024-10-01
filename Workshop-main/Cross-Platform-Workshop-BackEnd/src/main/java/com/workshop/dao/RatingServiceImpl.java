package com.workshop.dao;

import com.workshop.dto.*;
import com.workshop.dto.useDTO.favoriteDTO;
import com.workshop.model.Rating;
import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import com.workshop.repositories.Course.CourseRepository;
import com.workshop.repositories.RatingRepository;
import com.workshop.repositories.User.UserRepository;
import com.workshop.service.RatingService;
import com.workshop.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RatingServiceImpl implements RatingService {
    private final UserService userService;
    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final RatingRepository ratingRepository;

    @Override
    public Boolean createOrUpdateRating(RatingRequest ratingRequest) {
       try{
           User user = userService.getCurrentUserDetails();
           Course course = courseRepository.findCourseById(ratingRequest.getWorkshopId());
           Optional<Rating> existingRating;
           Optional<User> teacher = userRepository.findById(ratingRequest.getTeacherId());
           Rating newRating = new Rating();
           if ("MENTOR".equals(ratingRequest.getTargetType())) {
               newRating.setUser(user);
               newRating.setTeacher(teacher.get());
              newRating.setWorkshop(course);
               newRating.setRating(ratingRequest.getRating());
               newRating.setComment(ratingRequest.getComment());
               newRating.setStatus(true);
               newRating.setTargetType("MENTOR");
           } else if ("WORKSHOP".equals(ratingRequest.getTargetType())) {
               newRating.setUser(user);
              newRating.setTeacher(teacher.get());
               newRating.setWorkshop(course);
               newRating.setRating(ratingRequest.getRating());
               newRating.setComment(ratingRequest.getComment());
               newRating.setStatus(true);
               newRating.setTargetType("WORKSHOP");
           } else {
               return false;
           }
           ratingRepository.save(newRating);
           return true;
       }catch (Exception e){
           return false;
       }
    }
    @Override
    public List<TeacherRatingDTO> ListTeacherSortByRating() {
        return ratingRepository.findTeachersSortedByAverageRating();
    }
    @Override
    public List<WorkshopRatingDTO> ListWorkshopSortByRating() {
        try{
            return ratingRepository.findAllWorkshopsWithRatingsSortedByRating().stream()
                    .filter(w -> w.getRating() != null && w.getRating() > 0)
                    .map(w -> {
                        Double roundedRating = BigDecimal.valueOf(w.getRating())
                                .setScale(1, RoundingMode.HALF_UP)
                                .doubleValue();
                        w.setRating(roundedRating);  // Assuming WorkshopRatingDTO has a setRating method
                        return w;})
                    .collect(Collectors.toList());
        }catch (Exception e){
            throw e;
        }

    }
    @Override
    public List<adminListRatingDTO> findAllRatingsWithDetails()
    {
        try{
            return ratingRepository.findAllRatingsWithDetails();

        }catch (Exception e){
            throw  e;
        }
    }

    @Override
    public List<favoriteDTO> listFavorite() {
        User user = userService.getCurrentUserDetails();
        try{
            return ratingRepository.findFavoritesByUserId(user.getId());
        }catch (Exception e){
            throw  e;
        }
    }

    @Override
    public List<HomePageListRatingDTO> findAllRatingsWithDetailsPublic(Long courseId,Long teacherId) {
        try{
            return ratingRepository.findAllRatingsByCourseIdAndTeacherId( courseId, teacherId);
        }catch (Exception e){
            throw  e;
        }
    }

    @Override
    public boolean settingStatusComment(Long id) {
        try {
            int result = ratingRepository.chanceStatusRatingById(id);
            return result > 0;
        } catch (Exception exception) {
            throw new RuntimeException("Error: " + exception);
        }
    }
}
