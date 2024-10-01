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
public class RatingRequest {
    private Long teacherId;
    private String targetType;
    private Long workshopId;
    private Double rating;
    private String comment;
}
