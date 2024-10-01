package com.workshop.dto.useDTO;

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
public class RatingResponse {
    private Long ratingId;
    private String user_name;
    private String user_img;
    private double ratingValue;
    private String type;
    private String comment;
    private Long objId;
    private String obj_name;
}
