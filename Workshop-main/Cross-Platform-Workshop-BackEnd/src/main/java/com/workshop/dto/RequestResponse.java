package com.workshop.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class RequestResponse {
    private Long id;
    private String type;
    private String status;
    private Long userId;
    private String userName;
    private Long workshopId;
    private String workshopName;
    private double value;
    private Long locationId;
    private String locationName;
    private LocalDateTime registrationDateTime;
}
