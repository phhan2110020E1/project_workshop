package com.workshop.repositories.User;

import com.workshop.model.Transaction;
import com.workshop.model.courseModel.Course;
import com.workshop.model.userModel.User;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.*;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findByCreatedDateBetween(Timestamp createdDate, Timestamp createdDate2);
    @Query("select u from User u where u.email =:email and u.isEnable =true")
    Optional<User> findByEmail(String email);
    @Query("select u from User u where u.email =:email ")
    Optional<User> findAllByEmail(String email);
    @Query("select u from User u where u.email =:email and u.isEnable =true")
    User getUserEditByMail(String email);
    @Query("select u from User u left join fetch u.userAddresses ua where u.email = :email and u.isEnable = true")
    Optional<User> findByEmailWithAddresses(String email);
    @Query(value = "SELECT u FROM User u " +
            "JOIN FETCH u.roles r " +
            "WHERE r.name = ?1")
    List<User> findUsersByRoleName(String roleName);
    @Modifying
    @Query(value = "select u.* from users u join public.users_role ur on u.id = ur.user_id\n" +
            "join public.roles r on ur.roles_id = r.id\n" +
            "where r.name != 'ADMIN'", nativeQuery = true)
    List<User> findUsersNonAdmin();

    @Transactional
    @Modifying
    @Query("UPDATE User u SET u.isEnable = CASE WHEN u.isEnable = true THEN false ELSE true END WHERE u.id = :id")
    int chanceStatusAccountById(Long id);

    @Transactional
    @Modifying
    @Query("UPDATE User u SET u.password =:NewPassword  WHERE u.id = :id")
    void chancePasswordAccountById(Long id, String NewPassword);

    @Transactional
    @Modifying
    @Query("UPDATE User u SET u.balance =:NewBalance  WHERE u.id = :id")
    void updateBalanceAccountById(Long id, Double NewBalance);
    @Transactional
    @Modifying
    @Query("UPDATE User u SET u.phoneNumber = :#{#user.phoneNumber},u.user_name =:#{#user.user_name},u.full_name =:#{#user.full_name},u.image_url =:#{#user.image_url} WHERE u.id = :#{#user.id}")
    void updateUser(@Param("user") User user);

    @Query(value = "SELECT u FROM User u JOIN u.roles r WHERE r.name = 'USER'")
    List<User> countUsersWithUserRole();
    @Query(value = "SELECT u FROM User u JOIN u.roles r WHERE r.name = 'SELLER'")
    List<User> countUsersWithSellerRole();

    @Query("SELECT u FROM User u WHERE u.createdDate >= :startOfMonth AND u.createdDate <= :endOfMonth")
    List<User> getUsersCreatedBetween(@Param("startOfMonth") LocalDateTime startOfMonth, @Param("endOfMonth") LocalDateTime endOfMonth);
    @Query("SELECT u FROM User u JOIN FETCH u.roles r WHERE u.createdDate >= :startOfMonth AND u.createdDate <= :endOfMonth AND r.name = :role")
    List<User> getUsersWithRolesAndRoleCreatedBetween(
            @Param("startOfMonth") LocalDateTime startOfMonth,
            @Param("endOfMonth") LocalDateTime endOfMonth,
            @Param("role") String role);
}
