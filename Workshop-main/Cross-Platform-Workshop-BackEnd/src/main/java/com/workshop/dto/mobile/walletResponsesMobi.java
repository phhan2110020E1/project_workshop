package com.workshop.dto.mobile;

import jakarta.annotation.Nullable;
import lombok.*;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.Collections;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class walletResponsesMobi {
    private double current_balance;
    @Nullable
    @Builder.Default
    private List<Transaction> transactions = Collections.emptyList();

    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Transaction {
        private Long id;
        private double amount;
        private String  status;
        private String type;
        private LocalDateTime transaction_date;
    }


}
