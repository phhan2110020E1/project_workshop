package com.workshop.model.userModel;

import com.workshop.model.BaseModel;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
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
@Table(name = "users_bank")
public class UserBanking extends BaseModel {
    private String bankName;
    private String bankAccount;
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

}
