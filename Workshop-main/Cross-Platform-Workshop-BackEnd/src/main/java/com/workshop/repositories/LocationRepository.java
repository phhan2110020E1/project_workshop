package com.workshop.repositories;

import com.workshop.model.Location;
import com.workshop.model.courseModel.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LocationRepository extends JpaRepository<Location,Long> {
    Location findLocationById(Long Id);
    @Modifying
    @Query("SELECT l FROM Location l ")
    List<Location> listLocationPublic();
}
