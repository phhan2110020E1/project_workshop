package com.workshop.dao;

import com.workshop.dto.TransactionDTO;
import com.workshop.dto.mobile.walletResponsesMobi;
import com.workshop.model.Transaction;
import com.workshop.model.userModel.User;
import com.workshop.repositories.TransactionRepository;
import com.workshop.service.TransactionService;
import com.workshop.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class TransactionServiceImpl implements TransactionService {
    private final TransactionRepository transactionRepository;
    private final UserService userService;

    @Override
    public List<TransactionDTO> TRANSACTION_DTO_LIST() {
        List<TransactionDTO> transactionDTOS = new ArrayList<>();
        List<Transaction> transactionList = transactionRepository.findAll();
        for (Transaction transaction : transactionList) {
            TransactionDTO transactionDTO = new TransactionDTO();
            transactionDTO.setTransactionDate(transaction.getTransactionDate())
                    .setType(transaction.getType()).setAmount(transaction.getAmount())
                    .setStatus(transaction.getStatus()).setUser_Name(transaction.getUser().getUser_name());
            transactionDTOS.add(transactionDTO);
        }
        return transactionDTOS;
    }

    @Override
    public walletResponsesMobi walletResponsesMobi() {
        User user = userService.getCurrentUserDetails();
        walletResponsesMobi wallet_responsesMobi = new walletResponsesMobi();
        if (user != null) {
            List<Transaction> transactionListData = transactionRepository.findByUser(user);
            Collections.sort(transactionListData, (t1, t2) -> t2.getTransactionDate().compareTo(t1.getTransactionDate()));
            List<walletResponsesMobi.Transaction> transactionList = new ArrayList<>();
            for (Transaction transaction : transactionListData) {
                String type;
                walletResponsesMobi.Transaction transactiondto = new walletResponsesMobi.Transaction();
                if (transaction.getType() == Transaction.Type.BUY_COURSE) {
                    type ="Buy WorkShop" + " "+ transaction.getRequest().getCourses().getName();
                } else {
                    type = transaction.getType().toString();
                }
                transactiondto.setId(transaction.getId())
                        .setAmount(transaction.getAmount())
                        .setType(type)
                        .setStatus(String.valueOf(transaction.getStatus()))
                        .setTransaction_date(transaction.getTransactionDate());
                transactionList.add(transactiondto);
            }
            wallet_responsesMobi.setCurrent_balance(user.getBalance()).setTransactions(transactionList);
            return wallet_responsesMobi;
        } else {
            return wallet_responsesMobi;
        }
    }
}
