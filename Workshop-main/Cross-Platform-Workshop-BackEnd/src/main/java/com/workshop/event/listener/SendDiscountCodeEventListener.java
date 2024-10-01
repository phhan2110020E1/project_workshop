package com.workshop.event.listener;

import com.workshop.event.SendDiscountCodeEvent;
import com.workshop.event.SendQrCodeEvent;
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
public class SendDiscountCodeEventListener
        implements ApplicationListener<SendDiscountCodeEvent> {
    private final JavaMailSender javaMailSender;

    @Override
    public void onApplicationEvent(SendDiscountCodeEvent event) {
        String discountCode = event.getDiscountCode();
        String WorkshopName = event.getWorkshopName();
        String email = event.getEmail();
        String userName = event.getUser_name();
        int discountValue = event.getDiscountValue();
        try {
            SendDiscountCode(discountCode, WorkshopName, email, userName,discountValue);
        } catch (MessagingException | UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    public void SendDiscountCode(String discountCode, String WorkshopName, String email, String userName,int discountValue) throws MessagingException, UnsupportedEncodingException {
        String subject = "Discount Code ";
        String senderName = "WorkShop";

        Map<String, String> variables = new HashMap<>();
        variables.put("discountCode", discountCode);
        variables.put("WorkshopName", WorkshopName);
        variables.put("user", userName);
        variables.put("discountValue", String.valueOf(discountValue));

        String htmlContent = readHtmlTemplate("sendDiscountCode.html");
        for (Map.Entry<String, String> entry : variables.entrySet()) {
            htmlContent = htmlContent.replace("${" + entry.getKey() + "}", entry.getValue());
        }
        MimeMessage message = javaMailSender.createMimeMessage();
        var messagehepler = new MimeMessageHelper(message);
        messagehepler.setFrom("hquan0401.hr@gmail.com", senderName);
        messagehepler.setTo(email);
        messagehepler.setSubject(subject);
        messagehepler.setText(htmlContent, true);
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
