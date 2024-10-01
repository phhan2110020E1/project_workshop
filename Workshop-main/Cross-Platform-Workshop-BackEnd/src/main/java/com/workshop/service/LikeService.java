package com.workshop.service;

import com.workshop.dto.LikeDTO;
import com.workshop.dto.TeacherRatingDTO;

import java.util.List;

public interface LikeService
{
    Boolean createLike (LikeDTO likeDTO);
    List<TeacherRatingDTO> getTopTeachersByLikes();
    boolean checkUserLike(Long workshopId);
    boolean checkUserLikeTeacher(Long teacherId);

}
