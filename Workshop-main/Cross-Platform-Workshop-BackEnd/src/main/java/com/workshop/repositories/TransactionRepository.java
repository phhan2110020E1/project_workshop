package com.workshop.repositories;

import com.workshop.model.Transaction;
import com.workshop.model.userModel.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction,Long> {

    List<Transaction> findByCreatedDateBetween(Timestamp createdDate, Timestamp createdDate2);
    List<Transaction> findByUser(User user);
    @Query("SELECT COUNT(t) FROM Transaction t WHERE t.status = 'COMPLETED'")
    long countSuccessfulTransactions();
    @Query("SELECT COUNT(t) FROM Transaction t WHERE t.status = 'FAILED'")
    long countFailedTransactions();

    @Query("SELECT COALESCE(SUM(t.amount), 0) FROM Transaction t WHERE t.status = 'COMPLETED' AND t.type = 'BUY_COURSE'")
    long getTotalAmountOfCompletedBuyCourseTransactions();

    @Query("SELECT COALESCE(SUM(t.amount), 0) FROM Transaction t WHERE t.status = 'COMPLETED' AND t.type = 'BUY_COURSE' AND t.transactionDate >= :startDate AND t.transactionDate <= :endDate")
    long getTotalAmountOfCompletedBuyCourseTransactionsInMount(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

}
