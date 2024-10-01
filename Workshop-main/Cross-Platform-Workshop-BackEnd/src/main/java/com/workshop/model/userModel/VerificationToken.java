package com.workshop.model.userModel;

import com.workshop.model.BaseModel;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Calendar;
import java.util.Date;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Accessors(chain = true)
@Table(name = "verification_token")
public class VerificationToken extends BaseModel {
    private String token;
    private Date expirationTime;
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    public VerificationToken(String token, User user) {
        super();
        this.token = token;
        this.expirationTime = this.getTokenExpirationTime();
        this.user = user;
    }
    public VerificationToken(String token) {
        super();
        this.token = token;
        this.expirationTime = this.getTokenExpirationTime();
    }
    public Date getTokenExpirationTime() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(new Date().getTime());
        calendar.add(Calendar.MINUTE,10);
        return new Date(calendar.getTime().getTime());
    }
}
