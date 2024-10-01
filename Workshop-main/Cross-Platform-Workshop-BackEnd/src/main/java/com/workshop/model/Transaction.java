package com.workshop.model;

import com.workshop.model.courseModel.CourseEnrollment;
import com.workshop.model.userModel.User;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;


import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="transactions")
public class Transaction extends BaseModel{
    private double amount;
    @Enumerated(EnumType.STRING)
    private Status status;
    @Enumerated(EnumType.STRING)
    private Type type;
    private LocalDateTime transactionDate;

    @ManyToOne
    @JoinColumn(name = "enrollment_id")
    private Enrollment enrollment;

    @ManyToOne
    @JoinColumn(name = "request_id")
    private Request request;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "course_enrollment_id")
    private CourseEnrollment courseEnrollment;

    @ManyToOne
    @JoinColumn(name = "payment_method_id")
    private PaymentMethod paymentMethod;

    public enum Status{
        PENDING,
        COMPLETED,
        FAILED,
        CANCELED,
        REFUND;
    }
    public enum Type{
        DEPOSIT,
        BUY_COURSE,
        BUY_WORKSHOP,
        WITHDRAW;
    }
}
