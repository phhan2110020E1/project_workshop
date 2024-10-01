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
public class adminListRatingDTO {
    private String targetType;
    private Long rating_id;
    private Long workshop_id ;
    private Long mentor_id ;
    private String workshop_name ;
    private String mentor_name ;
    private String workshop_img ;
    private String mentor_img ;
    private String user_comment_name ;
    private Long user_comment_id ;
    private String user_comment_img ;
    private Double rating;
    private String comment;
    private boolean status ;
}
