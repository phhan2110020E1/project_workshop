package com.workshop.dao;

import com.workshop.config.MapperGeneric;
import com.workshop.dto.CourseDTO.CourseResponses;
import com.workshop.dto.LocationDTO;
import com.workshop.model.Location;
import com.workshop.repositories.LocationRepository;
import com.workshop.service.LocationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LocationServiceImpl implements LocationService {

    private final LocationRepository locationRepository;
    @Override
    public void AddLocation(Location location) {
       try{
           locationRepository.save(location);
       }catch (Exception ignored){
       }
    }

    @Override
    public List<LocationDTO> listLocation() {
        try{
            MapperGeneric<Location, LocationDTO> locationMapper = new MapperGeneric<>();
            List<Location> listLocation = locationRepository.listLocationPublic();
            List<LocationDTO>listLocationResponse = new ArrayList<>();
            for(Location location :  listLocation){

                LocationDTO locationDTO = locationMapper.ModelmapToDTO(location, LocationDTO.class);
                locationDTO.setId(location.getId());
                listLocationResponse.add(locationDTO);
            }
            return listLocationResponse;
        }catch (Exception ignored){
            throw ignored;
        }
    }
}
