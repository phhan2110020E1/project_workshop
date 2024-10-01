package com.workshop.model;

import com.workshop.model.courseModel.CourseDiscount;
import com.workshop.model.userModel.User;
import jakarta.persistence.*;
import jakarta.persistence.Table;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.*;

import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="discount")
public class Discount extends BaseModel{
    private String name;
    private String description;
    private int valueDiscount ;
    private int remainingUses;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "discount")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<CourseDiscount> courseDiscounts;

}
