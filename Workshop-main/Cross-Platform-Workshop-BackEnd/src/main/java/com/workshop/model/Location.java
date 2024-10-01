package com.workshop.model;

import com.workshop.model.courseModel.CourseLocation;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="location")
public class Location extends BaseModel{
    private String name;
    private String address;
    private String description;
    private String statusAvailable;
    @OneToMany(mappedBy = "location")
    private List<Request> requests;
    @OneToMany(mappedBy = "locations")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<CourseLocation> CourseLocation;
}
