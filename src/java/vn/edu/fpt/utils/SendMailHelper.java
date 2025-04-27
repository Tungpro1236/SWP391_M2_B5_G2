/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.utils;

//import java.net.Authenticator;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author LENOVO
 */
public class SendMailHelper {

    public static void sendEmailTo(String receiEmail, String header, String body) {
        final String email = GoogleInfomation.GOOGLE_EMAIL;
        final String password = GoogleInfomation.GOOGLE_PASSWORD;
        final String toEmail = receiEmail;

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com"); //SMTP host
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true"); // 
        prop.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(email, password);
            }
        };

        Session session = Session.getInstance(prop, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            // kieu noi dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            // nguoi gui
            msg.setFrom(email);
            //nguoi nhan
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            // tieu de
            msg.setSubject(header);
            // noi dung
            msg.setText(body);
            Transport.send(msg);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    
    public void sendEmailToTicket(String receiEmail, String header, String body) {
        final String email = GoogleInfomation.GOOGLE_EMAIL;
        final String password = GoogleInfomation.GOOGLE_PASSWORD;
        final String toEmail = receiEmail;

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com"); //SMTP host
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true"); // 
        prop.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(email, password);
            }
        };

        Session session = Session.getInstance(prop, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            // kieu noi dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            // nguoi gui
            msg.setFrom(email);
            //nguoi nhan
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            // tieu de
            msg.setSubject(header);
            // noi dung
            msg.setContent(body, "text/HTML; charset=UTF-8");
            Transport.send(msg);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
//        final String email = "toantthe176599@fpt.edu.vn";
//        final String password = "vfzm nrgn ggon ssqw";
//        final String toEmail = "vipboyxu2k3@gmail.com";
//        
//        Properties prop = new Properties();
//        prop.put("mail.smtp.host", "smtp.gmail.com"); //SMTP host
//        prop.put("mail.smtp.port", "587");
//        prop.put("mail.smtp.auth", "true"); // 
//        prop.put("mail.smtp.starttls.enable", "true");
//
//        Authenticator auth = new Authenticator() {
//            @Override
//            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
//                return new javax.mail.PasswordAuthentication(email, password);
//            }
//        };
//
//        Session session = Session.getInstance(prop, auth);
//        MimeMessage msg = new MimeMessage(session);
//        try {
//            // kieu noi dung
//            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
//            // nguoi gui
//            msg.setFrom(email);
//            //nguoi nhan
//            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
//            // tieu de
//            msg.setSubject("hello my friend");
//            // noi dung
//            msg.setText("djt meo may");
//            Transport.send(msg);
//        } catch (Exception e) {
//            System.out.println(e);
//        }

    }
}
