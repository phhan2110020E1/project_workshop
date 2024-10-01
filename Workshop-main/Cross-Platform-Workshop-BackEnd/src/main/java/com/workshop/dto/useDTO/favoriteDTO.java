package com.workshop.dto.useDTO;

import lombok.*;
import lombok.experimental.Accessors;

@Data
@Builder
@NoArgsConstructor
@Accessors(chain = true)
@Getter
@Setter
public class favoriteDTO {
    private Long ratingId;
    private String targetType;
    private Long teacher_id;
    private String teacher_name;
    private String teacher_image;
    private Double total_rating;
    private Long total_like;

    private Long work_id;
    private String work_name;
    private String work_image;
    private Double totalWorkshop_rating;
    private Long totalWorkshop_like;
    public favoriteDTO(Long ratingId,String targetType,Long teacher_id, String teacher_name, String teacher_image, Double total_rating,
                       Long total_like,Long work_id, String work_name, String work_image, Double totalWorkshop_rating,Long totalWorkshop_like) {
        this.ratingId = ratingId;
        this.targetType = targetType;
        this.teacher_id = teacher_id;
        this.teacher_name = teacher_name;
        this.teacher_image = teacher_image;
        this.total_rating = total_rating;
        this.total_like = total_like;
        this.work_id = work_id;
        this.work_name = work_name;
        this.work_image = work_image;
        this.totalWorkshop_rating = totalWorkshop_rating;
        this.totalWorkshop_like = totalWorkshop_like;
    }
}
