package com.workshop.dto;

import com.workshop.model.Transaction;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class TransactionDTO {
    private double amount;
    @Enumerated(EnumType.STRING)
    private Transaction.Status status;
    @Enumerated(EnumType.STRING)
    private Transaction.Type type;
    private LocalDateTime transactionDate;
    private String User_Name;
}
