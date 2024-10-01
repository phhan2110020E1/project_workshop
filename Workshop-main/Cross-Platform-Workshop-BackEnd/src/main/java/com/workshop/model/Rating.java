package com.workshop.model;

import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="user_ratings")
public class Rating extends BaseModel
{

    private Double rating;
    @Column(length = 5000)
    private String comment;
    private boolean status;
    private String targetType;
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "teacher_id")
    private User teacher;

    @ManyToOne
    @JoinColumn(name = "workshop_id")
    private Course workshop;
}
