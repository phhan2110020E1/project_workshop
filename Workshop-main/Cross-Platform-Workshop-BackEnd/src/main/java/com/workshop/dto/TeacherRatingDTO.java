package com.workshop.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class TeacherRatingDTO
{
    private Long id;
    private String targetType;
    private String full_name;
    private String user_name;
    private String email;
    private String phoneNumber;
    private String image_url;
    private String gender;
    private Double rating;
    private Long like;
    public TeacherRatingDTO(Long id,String targetType, String full_name, String user_name, String email,
                            String phoneNumber, String image_url, String gender, Long like) {
        this.id = id;
        this.targetType = targetType;
        this.full_name = full_name;
        this.user_name = user_name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.image_url = image_url;
        this.gender = gender;
        this.like = like;
    }
}
