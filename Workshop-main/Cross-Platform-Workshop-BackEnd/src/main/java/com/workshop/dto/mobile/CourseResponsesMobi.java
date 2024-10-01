package com.workshop.dto.mobile;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.workshop.dto.CourseDTO.CourseResponses;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.Accessors;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class CourseResponsesMobi {
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
    private int student_endroll;
    @NotNull
    private String Teacher;
    @NotNull
    private boolean isPublic;
    @NotNull
    private String urlQrCode;
    @JsonProperty("courseLocations")
    @Nullable
    @Builder.Default
    private List<CourseLocationMobi> courseLocations = Collections.emptyList();
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class CourseLocationMobi {
        private Long id;
        private String Area;
        private Date schedule_Date;
        private String statusAvailable;
        private String name;
        private String address;
        private String description;

    }

}
