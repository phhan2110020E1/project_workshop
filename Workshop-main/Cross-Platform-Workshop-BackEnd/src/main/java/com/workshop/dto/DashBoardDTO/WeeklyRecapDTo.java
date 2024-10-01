package com.workshop.dto.DashBoardDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class WeeklyRecapDTo {
    private String nameOfDay;
    private int requestApproved;
    private int requestPending;
    private int requestCancel;
    private int transactionDeposit;
    private int transactionWithdraw;
    private int transactionByWorkshop;
}
