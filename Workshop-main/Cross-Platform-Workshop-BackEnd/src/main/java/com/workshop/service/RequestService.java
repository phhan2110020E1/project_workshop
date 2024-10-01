package com.workshop.service;
import com.workshop.config.cloud.ResponseRequestOptions;
import com.workshop.dto.RequestDTO.RequestDTO;
import com.workshop.dto.RequestResponse;
import com.workshop.model.Request;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface RequestService {
    List<RequestResponse> ListRequest();
    ResponseRequestOptions createRequestOptions(RequestDTO requestDTO);
    boolean changeStatusRequest(Long request_id);
}
