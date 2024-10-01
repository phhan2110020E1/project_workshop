package com.workshop.service;


import com.workshop.dto.*;
import com.workshop.dto.useDTO.favoriteDTO;

import java.util.List;

public interface RatingService {

    Boolean createOrUpdateRating(RatingRequest ratingRequest);
    List<TeacherRatingDTO> ListTeacherSortByRating();
    List<WorkshopRatingDTO> ListWorkshopSortByRating();
    List<adminListRatingDTO> findAllRatingsWithDetails();
    List<favoriteDTO> listFavorite();
    List<HomePageListRatingDTO> findAllRatingsWithDetailsPublic(Long courseId,Long teacherId );
    boolean settingStatusComment(Long id);
}
