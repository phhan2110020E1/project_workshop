package com.workshop.event;

import com.workshop.model.userModel.User;
import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

import java.time.Clock;

@Getter
@Setter
public class RegisterCompleteEvent extends ApplicationEvent {
    private User user;
    private String url;

    public RegisterCompleteEvent( User user, String url) {
        super(user);
        this.user = user;
        this.url = url;
    }
}
