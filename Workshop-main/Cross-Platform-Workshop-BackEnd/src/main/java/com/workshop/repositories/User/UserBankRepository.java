package com.workshop.repositories.User;

import com.workshop.model.userModel.User;
import com.workshop.model.userModel.UserBanking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UserBankRepository extends JpaRepository<UserBanking,Long> {

    @Transactional
    @Modifying
    @Query("UPDATE UserBanking u SET u.bankAccount = :#{#userBanking.bankAccount}," +
            "u.bankName = :#{#userBanking.bankName} WHERE u.id = :Id")
    void updateUserBankById(@Param("Id") Long Id, @Param("userBanking") UserBanking userBanking);

    @Transactional
    int deleteUserBankingByUserAndId(User user, Long id);
}
