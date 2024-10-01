package com.workshop.dto.CourseDTO;


import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.Accessors;
import java.sql.Timestamp;
import java.util.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class CourseRequest {
    @NotNull
    private String name;
    @NotNull
    private String description;
    @NotNull
    private double price;
    @NotNull
    private Timestamp startDate;
    @NotNull
    private Timestamp endDate;
    @NotNull
    private int student_count;
    @NotNull
    private String type;
    @JsonProperty("mediaInfoList")
    @Nullable
    @Builder.Default
    private List<CourseMediaInfoDTOS> mediaInfoList = Collections.emptyList();

    @JsonProperty("discountDTOS")
    @Nullable
    @Builder.Default
    private List<DiscountDTO> discountDTOS = Collections.emptyList();

    @JsonProperty("courseLocation")
    @Nullable
    @Builder.Default
    private List<CourseLocation> courseLocation = Collections.emptyList();

    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CourseMediaInfoDTOS{
        private String urlMedia;
        private String urlImage;
        private String thumbnailSrc;
        private String title;
    }
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class DiscountDTO {
        private int quantity;
        private Date redemptionDate;
        private int valueDiscount ;
        private String name;
        private String description;
        private int remainingUses;
    }
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CourseLocation {
        private String Area;
        private Date schedule_Date;
    }

}
