package com.workshop.event;

import com.workshop.model.userModel.User;
import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

@Getter
@Setter
public class RenewPasswordEvent extends ApplicationEvent {
    private String Password;
    private String url;
    private String Mail;

    public RenewPasswordEvent(String Mail,String Password, String url) {
        super(Password);
        this.Password = Password;
        this.url = url;
        this.Mail =Mail;
    }
}
