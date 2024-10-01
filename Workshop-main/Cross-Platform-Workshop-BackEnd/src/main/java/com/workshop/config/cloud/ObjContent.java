package com.workshop.config.cloud;

import lombok.*;
import lombok.experimental.Accessors;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class ObjContent {
    private Long user_id;
    private String user_name;
    private Long workshop_id;
    private String workshop_name;
    private String email;
    private boolean status;
}
