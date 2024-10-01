package com.workshop.model.courseModel;

import com.workshop.model.BaseModel;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="course_media_info")
public class CourseMediaInfo extends BaseModel {
    private String urlMedia;
    private String urlImage;
    private String thumbnailSrc;
    private String title;
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
}
