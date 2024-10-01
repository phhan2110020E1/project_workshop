package com.workshop.model;

import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;


import java.util.List;
import java.util.Set;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="requesttb")
public class Request extends BaseModel{

    @Enumerated(EnumType.STRING)
    private RequestType type;
    @Enumerated(EnumType.STRING)
    private RequestStatus status;
    private double value;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course courses;
    @ManyToOne
    @JoinColumn(name = "location_id")
    private Location location;
    @OneToMany(mappedBy = "request")
    private List<Transaction> transactions;
    public enum RequestStatus {
        PENDING,
        APPROVED,
        REJECTED,
        CANCEL,
    }
    public enum RequestType {
        DEPOSIT,
        BUY_COURSE,
        BUY_WORKSHOP,
        WITHDRAW,
        HANDLE_WITHDRAW,
        REGISTER_COURSE_OFFLINE,
    }
}
