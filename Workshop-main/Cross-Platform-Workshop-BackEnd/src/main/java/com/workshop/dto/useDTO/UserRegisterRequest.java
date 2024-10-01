package com.workshop.dto.useDTO;

import lombok.*;
import lombok.experimental.Accessors;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class UserRegisterRequest {

    private String full_name ="";
    private Double balance=0.0;
    private String user_name;
    private String email;
    private String password;
    private String phoneNumber;
    private String gender;
    private String role;
    private boolean isEnable = false;
}
