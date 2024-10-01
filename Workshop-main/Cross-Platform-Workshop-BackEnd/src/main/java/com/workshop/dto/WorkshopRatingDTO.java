package com.workshop.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Builder
@NoArgsConstructor
@Accessors(chain = true)
public class WorkshopRatingDTO
{
    private Long id;
    private String targetType;
    private String workshop_name;
    private String workshop_ImageUrl;
    private Long teacher_id;
    private String teacher_name;
    private String teacher_image;
    private Double rating ;
    private double price ;

    public WorkshopRatingDTO(Long id,String targetType, String workshop_name,
                             String workshop_ImageUrl,
                             Long teacher_id,
                             String teacher_name,
                             String teacher_image,
                             Double rating,
                             double price) {
        this.id = id;
        this.targetType = targetType;
        this.workshop_name = workshop_name;
        this.workshop_ImageUrl = workshop_ImageUrl;
        this.teacher_id = teacher_id;
        this.teacher_name = teacher_name;
        this.teacher_image = teacher_image;
        this.rating = rating;

        this.price = price;
    }
}
