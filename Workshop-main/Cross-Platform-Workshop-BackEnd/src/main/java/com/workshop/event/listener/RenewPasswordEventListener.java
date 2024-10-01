package com.workshop.event.listener;

import com.workshop.event.RenewPasswordEvent;
import com.workshop.service.UserService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationListener;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class RenewPasswordEventListener  implements ApplicationListener<RenewPasswordEvent> {
    private final UserService userService;
    private  final JavaMailSender javaMailSender;
    @Override
    public void onApplicationEvent(RenewPasswordEvent event) {
        String Email = event.getMail();
        String Password = event.getPassword();
        try {
            sendVerificationMail(Email,Password);
        }catch (MessagingException | UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }
    public void sendVerificationMail(String mail,  String Password) throws MessagingException, UnsupportedEncodingException {
        String subject = "Email Verification";
        String senderName = "User Renew Password Service WorkShop";
        Map<String, String> variables = new HashMap<>();
        variables.put("password", Password);


        String htmlContent = readHtmlTemplate("sendPassword.html");
        for (Map.Entry<String, String> entry : variables.entrySet()) {
            htmlContent = htmlContent.replace("${" + entry.getKey() + "}", entry.getValue());
        }
        MimeMessage message =javaMailSender.createMimeMessage();
        var messagehepler = new MimeMessageHelper(message);
        messagehepler.setFrom("workshopproject04@gmail.com",senderName);
        messagehepler.setTo(mail);
        messagehepler.setSubject(subject);
        messagehepler.setText(htmlContent,true);
        javaMailSender.send((message));
    }
    private String readHtmlTemplate(String templatePath) {
        try {
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream(templatePath);
            if (inputStream != null) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
                StringBuilder htmlContent = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    htmlContent.append(line);
                }
                return htmlContent.toString();
            } else {
                throw new FileNotFoundException("Template file not found: " + templatePath);
            }
        } catch (IOException e) {
            throw new RuntimeException("Error reading HTML template", e);
        }
    }


}
