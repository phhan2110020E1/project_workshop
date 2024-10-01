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
@Table(name="user_address")
@Accessors(chain = true)
public class UserAddresses extends BaseModel {
    private String Address;
    private String City;
    private String State;
    private int PostalCode;

    @ManyToOne
    @JoinColumn(name = "userFkId")
    private User user;
}
