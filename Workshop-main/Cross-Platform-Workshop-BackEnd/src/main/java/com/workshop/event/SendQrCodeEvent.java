package com.workshop.event;

import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

@Getter
@Setter
public class SendQrCodeEvent extends ApplicationEvent {
    private String user_name;
    private String email;
    private String url;
    private String workshop_name;

    public SendQrCodeEvent(String user_name,String email, String url,String workshop_name) {
        super(user_name);
        this.user_name = user_name;
        this.email = email;
        this.url = url;
        this.workshop_name = workshop_name;
    }
}
