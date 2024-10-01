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
public class CourseResponses {
    private Long id;
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
    @NotNull
    private Long Teacher_id;
    @NotNull
    private String Teacher;
    @NotNull
    private String Teacher_img;
    @NotNull
    private boolean isPublic;

    @JsonProperty("studentEnrollments")
    @Nullable
    @Builder.Default
    private List<StudentEnrollment> studentEnrollments = Collections.emptyList();
    @JsonProperty("courseMediaInfos")
    @Nullable
    @Builder.Default
    private List<CourseMediaInfo> courseMediaInfos = Collections.emptyList();
    @JsonProperty("courseLocations")
    @Nullable
    @Builder.Default
    private List<CourseLocation> courseLocations = Collections.emptyList();
    @JsonProperty("discountDTOS")
    @Nullable
    @Builder.Default
    private List<DiscountDTO> discountDTOS = Collections.emptyList();
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class StudentEnrollment {
        private Long id;
        private String name;
    }
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class DiscountDTO {
        private Long id;
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
    public static class CourseMediaInfo {
        private Long id;
        private String urlMedia;
        private String urlImage;
        private String thumbnailSrc;
        private String title;
    }
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CourseLocation {
        private Long id;
        private String Area;
        private Date schedule_Date;
        @Nullable
        @JsonProperty("locationDTO")
        private locationResponse locationResponse = new locationResponse();
        @Getter
        @Setter
        @AllArgsConstructor
        @NoArgsConstructor
        public static class locationResponse {
            private Long id;
            private String name;
            private String statusAvailable;
            private String address;
            private String description;
        }
    }
}
