package com.workshop.service;

import com.workshop.dto.LocationDTO;
import com.workshop.model.Location;

import java.util.List;

public interface LocationService {
    void AddLocation(Location location);
    List<LocationDTO> listLocation ();
}
