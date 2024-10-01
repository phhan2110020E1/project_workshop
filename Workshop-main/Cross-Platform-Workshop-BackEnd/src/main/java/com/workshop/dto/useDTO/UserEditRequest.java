package com.workshop.dto.useDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.annotation.Nullable;
import lombok.*;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class UserEditRequest {
    private String full_name;
    private String user_name;
    private String email;
    private String phoneNumber;
    private Double balance;
    private String image_url;
    @JsonProperty("userAddresses")
    @Nullable
    @Builder.Default
    private List<UserAddress> userAddresses = Collections.emptyList();
    @JsonProperty("userBank")
    @Nullable
    @Builder.Default
    private List<UserBank> userBanks = Collections.emptyList();
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UserAddress {
        private Long id;
        private String Address;
        private String City;
        private String State;
        private int PostalCode;
    }
    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UserBank {
        private Long id;
        private String bankName;
        private String bankAccount;
    }

}
