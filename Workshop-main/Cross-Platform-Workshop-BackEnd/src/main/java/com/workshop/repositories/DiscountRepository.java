package com.workshop.repositories;

import com.workshop.model.Discount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface DiscountRepository extends JpaRepository<Discount,Long> {

    @Transactional
    @Modifying
    @Query("UPDATE Discount d SET d.name = :#{#discount.name}," +
            " d.description = :#{#discount.description}," +
            "d.valueDiscount = :#{#discount.valueDiscount}," +
            "d.remainingUses = :#{#discount.remainingUses} WHERE d.id = :Id")
    void updateDiscount(@Param("Id") Long Id, @Param("discount") Discount discount);
}
