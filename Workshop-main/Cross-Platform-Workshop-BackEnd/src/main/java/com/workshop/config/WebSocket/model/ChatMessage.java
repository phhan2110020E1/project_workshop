package com.workshop.config.WebSocket.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.awt.*;
import java.sql.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
@ToString
@Accessors(chain = true)
public class ChatMessage {
    private MessageType type;
    private String content;
    private String sender;

    public enum MessageType {
        CHAT,
        JOIN,
        LEAVE
    }
}
