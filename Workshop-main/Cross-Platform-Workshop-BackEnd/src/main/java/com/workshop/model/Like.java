package com.workshop.model;

import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
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
@Table(name="user_likes")
public class Like extends BaseModel
{
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    private String targetType;
    @ManyToOne
    @JoinColumn(name = "teacher_id")
    private User teacher;
    @ManyToOne
    @JoinColumn(name = "workshop_id")
    private Course workshop;
}
