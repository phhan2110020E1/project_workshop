package com.workshop.model;
import jakarta.persistence.MappedSuperclass;
import lombok.*;
import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import java.sql.Timestamp;

@MappedSuperclass
@Data
@EntityListeners(AuditingEntityListener.class)
public abstract class BaseModel   {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @CreatedBy
    @Column(name = "created_by",updatable = false)
    private String createdBy;

    @CreatedDate
    @Column(name = "created_date",updatable = false)
    private Timestamp createdDate;

    @LastModifiedBy
    @Column(name = "last_modified_by",nullable = true)
    private String lastModifiedBy;

    @LastModifiedDate
    @Column(name = "last_modified_date",nullable = true)
    private Timestamp lastModifiedDate;


}
