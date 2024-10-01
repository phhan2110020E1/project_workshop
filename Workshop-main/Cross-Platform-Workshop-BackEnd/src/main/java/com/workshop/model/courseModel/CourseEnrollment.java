package com.workshop.model.courseModel;

import com.workshop.model.BaseModel;

import com.workshop.model.Transaction;
import com.workshop.model.userModel.User;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name = "course_enrollments")
public class CourseEnrollment extends BaseModel {

    private Date enrollmentDate;
    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private User enrolledStudent;

    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    private Course courses;

    @OneToMany(mappedBy = "courseEnrollment")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<Transaction> transactions;
}
