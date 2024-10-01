package com.workshop.dto.RequestDTO;
import lombok.*;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class RequestDTO {
    private String type;
    private Long requestId;
    private String status = "PENDING";
    private Long item_register_id;
    private Long locationId;
    private Double amount;
    private Double discountAmount;
    private String discountCode;
    private String paymentName;
    private String paymentStatus;
}
