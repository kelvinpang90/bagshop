package com.pwk.tools;

import com.pwk.entity.MailSenderInfo;

import javax.mail.*;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.util.Properties;

/**
 * Created by Administrator on 2014/4/27.
 */
public class GmailSender {
    public static boolean send(MailSenderInfo mailSenderInfo){
        try {
            mailSenderInfo.setUserName("myparisbag@gmail.com");
            mailSenderInfo.setPassword("19900108pwk");
            mailSenderInfo.setFromAddress("MyParisBags");

            String to = mailSenderInfo.getToAddress();
            String from = mailSenderInfo.getFromAddress();
            final String username = mailSenderInfo.getUserName();
            final String password = mailSenderInfo.getPassword();

            String host = "smtp.gmail.com";

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props,
                    new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });


            // Create a default MimeMessage object.
            Message message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));

            // Set Subject: header field
            message.setSubject(mailSenderInfo.getSubject());

            // Now set the actual message
            Multipart mainPart = new MimeMultipart();
            BodyPart html = new MimeBodyPart();
            html.setContent(mailSenderInfo.getContent(), "text/html; charset=utf-8");
            mainPart.addBodyPart(html);
            message.setContent(mainPart);

            // Send message
            System.out.println("正在发送gmail邮件！");
            Transport.send(message);

            System.out.println("gmail邮件发送成功！");

            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
