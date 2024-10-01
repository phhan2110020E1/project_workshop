package com.workshop.event;

import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

@Getter
@Setter
public class SendDiscountCodeEvent extends ApplicationEvent {
    private String user_name;
    private String email;
    private String workshopName;
    private String discountCode;
    private int discountValue;

    public SendDiscountCodeEvent(String user_name, String email, String workshopName, String discountCode, int discountValue) {
        super(user_name);
        this.user_name = user_name;
        this.email = email;
        this.workshopName = workshopName;
        this.discountCode = discountCode;
        this.discountValue = discountValue;
    }
}
