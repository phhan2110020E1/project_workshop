package com.workshop.model.userModel;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.workshop.model.*;
import com.workshop.model.courseModel.Course;
import com.workshop.model.courseModel.CourseEnrollment;
import com.workshop.model.courseModel.QrToken;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.NaturalId;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.*;


@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name = "users")
public class User extends BaseModel implements UserDetails  {

    private String full_name;
    private String user_name;
    @NaturalId(mutable = true)
    private String email;
    private String gender;
    private String password;
    private String phoneNumber;

    @JsonFormat(shape = JsonFormat.Shape.NUMBER_FLOAT, pattern = "#.##")
    private Double balance;
    private boolean isEnable = false;

    private String image_url;
    @OneToOne(mappedBy = "user")
    private VerificationToken verificationToken;
    // Quan hệ một nhiều với khóa học đã tạo bởi giáo viên
    @OneToMany(mappedBy = "teacher")
    private List<Course> teacherCourses;
    // Quan hệ một nhiều với khóa học và buổi workshop đã đăng ký
    @OneToMany(mappedBy = "enrolledStudent")
    private List<CourseEnrollment> enrolledCourses;

    @OneToMany(mappedBy = "user")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<QrToken> qrTokens;

    @OneToMany(mappedBy = "user")
    private List<UserBanking> userBanks;
    @OneToMany(mappedBy = "user")
    private List<UserAddresses> userAddresses;

    @OneToMany(mappedBy = "user")
    private List<Discount> discounts;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="users_role",
            joinColumns = @JoinColumn(name="User_id"),
            inverseJoinColumns = @JoinColumn(name="Roles_id"))
    private Set<Roles> roles = new HashSet<>();
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<SimpleGrantedAuthority> authority = new ArrayList<>();
        roles.stream().forEach(i->authority.add(new SimpleGrantedAuthority(i.getName())));
        return List.of(new SimpleGrantedAuthority((authority.toString())));
    }
    @Override
    public String getUsername() {
        return email;
    }
    @Override
    public String getPassword() {
        return password;
    }
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    @Override
    public boolean isEnabled() {
        return true;
    }
}
