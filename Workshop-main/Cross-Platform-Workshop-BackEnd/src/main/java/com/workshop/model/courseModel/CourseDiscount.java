package com.workshop.model.courseModel;

import com.workshop.model.BaseModel;
import com.workshop.model.Discount;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Date;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name = "course_discounts")
public class CourseDiscount extends BaseModel {
    private Date redemptionDate;
    private int quantity;
    private String code;
    @Enumerated(EnumType.STRING)
    private Status status;
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    @ManyToOne
    @JoinColumn(name = "discount_id")
    private Discount discount;

    public enum Status{
        NotAvailable,
        Available,
        Email_Sent
    }

}
