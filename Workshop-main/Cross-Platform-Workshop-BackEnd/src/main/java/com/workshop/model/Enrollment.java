package com.workshop.model;

import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="enrollment")
public class Enrollment extends BaseModel {

    private Date enrollmentDate;
    @ManyToOne
    @JoinColumn(name = "student_id")
    private User enrolledStudent;
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    @OneToMany(mappedBy = "enrollment")
    private List<Transaction> transactions;
}