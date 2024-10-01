package com.workshop.service;
import com.workshop.dto.TransactionDTO;
import com.workshop.dto.mobile.walletResponsesMobi;
import com.workshop.model.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface TransactionService {

    List<TransactionDTO> TRANSACTION_DTO_LIST();
    walletResponsesMobi walletResponsesMobi();
}
