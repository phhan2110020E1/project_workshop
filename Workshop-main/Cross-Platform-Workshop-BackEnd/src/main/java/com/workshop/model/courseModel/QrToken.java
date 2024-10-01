package com.workshop.model.courseModel;

import com.workshop.model.BaseModel;
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
@Table(name="qr_token")
public class QrToken extends BaseModel {

    private String name;
    private String email;
    @Column(columnDefinition = "TEXT", length = 1000)
    private String urlQrCode;

    private boolean status;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
