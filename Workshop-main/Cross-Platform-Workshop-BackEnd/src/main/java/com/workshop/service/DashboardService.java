package com.workshop.service;

import com.workshop.dto.DashBoardDTO.DashboardDTO;
import com.workshop.dto.DashBoardDTO.WeeklyRecapDTo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DashboardService {
     DashboardDTO Dashboard();
     List<WeeklyRecapDTo> WEEKLY_RECAP_D_TO_LIST();
}
