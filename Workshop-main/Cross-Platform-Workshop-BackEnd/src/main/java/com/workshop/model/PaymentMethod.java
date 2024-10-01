package com.workshop.model;

import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.List;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="payment_method")
public class PaymentMethod extends BaseModel{
    private String name;
    private String description;
    @OneToMany(mappedBy = "paymentMethod")
    private List<Transaction> transactions;

}
