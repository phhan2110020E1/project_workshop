package com.workshop.repositories.User;

import com.workshop.model.userModel.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends JpaRepository<Roles,Long>
{
    Roles findByName(String name);
    @Query("select ur from User u join u.roles ur WHERE u.email = :email")
    List<Roles> getRolesForUserByEmail(@Param("email") String email);
}
