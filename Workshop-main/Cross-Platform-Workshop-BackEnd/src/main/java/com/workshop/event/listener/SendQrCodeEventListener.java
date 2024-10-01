package com.workshop.event.listener;
import com.workshop.event.SendQrCodeEvent;
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

@Slf4j
@Component
@RequiredArgsConstructor
public class SendQrCodeEventListener
        implements ApplicationListener<SendQrCodeEvent>
{
    private  final JavaMailSender javaMailSender;
    @Override
    public void onApplicationEvent(SendQrCodeEvent event) {
        String user = event.getUser_name();
        String url = event.getUrl();
        String email = event.getEmail();
        String workshop_name = event.getWorkshop_name();
        try {
            sendQrCode(url,user,email,workshop_name);
        }catch (MessagingException | UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }
public void sendQrCode(String url,String user_name,String email,String workshop_name) throws MessagingException, UnsupportedEncodingException {
        String subject = "Ticker Qr Code";
        String senderName = "WorkShop";
        Map<String, String> variables = new HashMap<>();
        variables.put("workshop_name",workshop_name );
        variables.put("buyer",user_name );
        variables.put("urlCode",url );

        String htmlContent = readHtmlTemplate("sendQrCode.html");
        for (Map.Entry<String, String> entry : variables.entrySet()) {
            htmlContent = htmlContent.replace("${" + entry.getKey() + "}", entry.getValue());
        }
        MimeMessage message =javaMailSender.createMimeMessage();
        var messagehepler = new MimeMessageHelper(message);
        messagehepler.setFrom("hquan0401.hr@gmail.com",senderName);
        messagehepler.setTo(email);
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
