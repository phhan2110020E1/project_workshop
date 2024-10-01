package com.workshop.repositories;


import com.workshop.model.Request;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface RequestRepository extends JpaRepository<Request,Long> {
    List<Request> findByCreatedDateBetween(Timestamp createdDate, Timestamp createdDate2);


    @Transactional
    @Modifying
    @Query("UPDATE Request  r SET r.status = :status where r.id = :Id")
    void updateRequestStatusById(@Param("Id") Long Id, @Param("status") Request.RequestStatus status);
}
