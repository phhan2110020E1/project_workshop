package com.workshop.config;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ApiResponse<T> {
    private String status;
    private String message;
    private T data;
}
