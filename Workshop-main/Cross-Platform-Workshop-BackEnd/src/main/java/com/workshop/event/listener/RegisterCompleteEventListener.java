package com.workshop.event.listener;

import com.workshop.event.RegisterCompleteEvent;
import com.workshop.model.userModel.User;
import com.workshop.service.UserService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationListener;
import org.springframework.mail.javamail.*;
import org.springframework.stereotype.Component;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
@Slf4j
@Component
@RequiredArgsConstructor
public class RegisterCompleteEventListener
        implements ApplicationListener<RegisterCompleteEvent>
{
private final UserService userService;
private  final JavaMailSender javaMailSender;
    @Override
    public void onApplicationEvent(RegisterCompleteEvent event) {
        //1. Get New user
        User user = event.getUser();
        //2.Create VeryCode token for User
        String verificationToken = UUID.randomUUID().toString();
        //3.Save VerCode token for User
        userService.saveUserVerificationToken(user,verificationToken);
        //4.Build  the VerCode url to be sent
        String url = event.getUrl()+"/auth/verifyEmail?token="+verificationToken;
        //5.Send Email
        try {
            sendVerificationMail(url,user);
        }catch (MessagingException | UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        log.info("Click to link to very your account :{}",url);

    }

    public void sendVerificationMail(String url,User user) throws MessagingException, UnsupportedEncodingException {
        String subject = "Email Verification";
        String senderName = "User Register Service WorkShop";
        Map<String, String> variables = new HashMap<>();
        variables.put("username", user.getUser_name());
        variables.put("url", url);


        String htmlContent = readHtmlTemplate("sendmail.html");
        for (Map.Entry<String, String> entry : variables.entrySet()) {
            htmlContent = htmlContent.replace("${" + entry.getKey() + "}", entry.getValue());
        }
        MimeMessage message =javaMailSender.createMimeMessage();
        var messagehepler = new MimeMessageHelper(message);
        messagehepler.setFrom("hquan0401.hr@gmail.com",senderName);
        messagehepler.setTo(user.getEmail());
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
