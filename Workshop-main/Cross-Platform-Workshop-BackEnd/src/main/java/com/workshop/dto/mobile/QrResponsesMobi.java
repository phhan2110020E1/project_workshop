package com.workshop.dto.mobile;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.Accessors;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class QrResponsesMobi {

    @NotNull
    private String status;
    @NotNull
    private String message;

}
