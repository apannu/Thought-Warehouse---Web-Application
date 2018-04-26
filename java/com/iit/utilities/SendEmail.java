package com.iit.utilities;

import java.util.Properties;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.iit.domain.UserDTO;

public class SendEmail {
	
	//method to send an email for otp or confirmation
	public void sendEmailUsingSSL(String emailAddress, String Name, Integer OTP){
		Properties smtpServerProperties = new Properties();
		
		smtpServerProperties.put("mail.smtp.host", "smtp.gmail.com");
		smtpServerProperties.put("mail.smtp.socketFactory.port", "465");
		smtpServerProperties.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		smtpServerProperties.put("mail.smtp.auth", "true");
		smtpServerProperties.put("mail.smtp.port", "465");
		
		Session session = Session.getDefaultInstance(smtpServerProperties,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication("carrentalsystems1@gmail.com","SQL36oracle$$$");
					}
				});
		
		try {

			Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress("carrentalsystems1@gmail.com"));
			mimeMessage.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(emailAddress));
			mimeMessage.setSubject("Welcome Message");
			mimeMessage.setText("Dear " + Name +
					"\n\n Car Rental Team welcomes you. For security reasons, please keep your username and password secret."
					+ " \n\n You will be required to enter OTP as " + OTP +". "
							+ " \n\n For other queries please call our support desk at "
							+ " +1 (312)866-7564. ");

			Transport.send(mimeMessage);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//method to send an email for the confirmation of the booking
	public void sendConfirmationMail(UserDTO userDTOJDBC, String action){
		Properties smtpServerProperties = new Properties();
		
		smtpServerProperties.put("mail.smtp.host", "smtp.gmail.com");
		smtpServerProperties.put("mail.smtp.socketFactory.port", "465");
		smtpServerProperties.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		smtpServerProperties.put("mail.smtp.auth", "true");
		smtpServerProperties.put("mail.smtp.port", "465");
		
		Session session = Session.getDefaultInstance(smtpServerProperties,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
//						return new PasswordAuthentication("carrentalsystems1@gmail.com","SQL36oracle$$$$");
						return new PasswordAuthentication("anirudhpannu16477@gmail.com","SQL36ora$");
					}
				});
		
		try 
		{
			Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress("carrentalsystems1@gmail.com"));
			if(action.equals("register"))
			{
				mimeMessage.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(userDTOJDBC.getEmailId()));
				mimeMessage.setSubject("Profile Creation at Thought Warehouse");
				mimeMessage.setText("Hello " + userDTOJDBC.getFname() + ",\n\nGreetings!\n\n" + "Welcome to Thought Warehouse. Your profile has been created. Please confirm your details below:"
						+ "\n\n Username: "+userDTOJDBC.getUsername()
						+ "\n Password: "+userDTOJDBC.getPassword()
						+ "\n First Name: "+userDTOJDBC.getFname()
						+ "\n Last Name: "+userDTOJDBC.getLname()
						+ "\n Email Id: "+userDTOJDBC.getEmailId()
						+ "\n Contact: "+userDTOJDBC.getContact()
						+ "\n Company: "+userDTOJDBC.getCompanyName()
						+ "\n Profession: "+userDTOJDBC.getProfessionName()
						+ "\n Education: "+userDTOJDBC.getEducationName()
								+ " \n\nHowever, you can always go back to the application and edit your profile information. "
								+ " \n\nIn case of any queries, you can reach out to us @apannu@hawk.iit.edu or just pass on your query through the Contact section.\n\nThanks and Regards,\nThought Warehouse");
			}
			else if(action.equals("fbRegister"))
			{
				mimeMessage.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(userDTOJDBC.getFbEmailId()));
				mimeMessage.setSubject("Profile Creation at Thought Warehouse");
				mimeMessage.setText("Hello " + userDTOJDBC.getFbProfileName() + ",\n\nGreetings!\n\n" + "Welcome to Thought Warehouse. Your profile has been created using your profile name from Facebook. Please confirm your details below:"
						+ "\n\n First Name: "+userDTOJDBC.getFbProfileName().split(" ")[0]
						+ "\n Last Name: "+userDTOJDBC.getFbProfileName().split(" ")[1]
						+ "\n Email Id: "+userDTOJDBC.getFbEmailId()
						+ "\n Contact: "+userDTOJDBC.getFbContact()
						+ "\n Company: "+userDTOJDBC.getCompanyName()
						+ "\n Profession: "+userDTOJDBC.getProfessionName()
						+ "\n Education: "+userDTOJDBC.getEducationName()
								+ " \n\nHowever, you can always go back to the application and edit your profile information. "
								+ " \n\nIn case of any queries, you can reach out to us @apannu@hawk.iit.edu or just pass on your query through the Contact section.\n\nThanks and Regards,\nThought Warehouse");
			}
			else if(action.equals("updatePassword"))
			{
				mimeMessage.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(userDTOJDBC.getEmailId()));
				mimeMessage.setSubject("Password Updation at Thought Warehouse");
				mimeMessage.setText("Hello " + userDTOJDBC.getFname()+" "+userDTOJDBC.getLname() + ",\n\nGreetings!\n\n" + "Welcome to Thought Warehouse. Your password has been updated. Please confirm your details below:"
						+ "\n\n Old Password: "+userDTOJDBC.getPassword()
						+ "\n New Password: "+userDTOJDBC.getNewPassword()
								+ " \n\nHowever, you can always go back to the application and edit your profile information. "
								+ " \n\nIn case of any queries, you can reach out to us @apannu@hawk.iit.edu or just pass on your query through the Contact section.\n\nThanks and Regards,\nThought Warehouse");
			}
			else
			{
				mimeMessage.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(userDTOJDBC.getEmailId()));
				mimeMessage.setSubject("Profile Updation at Thought Warehouse");
				mimeMessage.setText("Hello " + userDTOJDBC.getFname() + ",\n\nGreetings!\n\n" + "Your profile has been updated. Please confirm your updated details below:"
						+ "\n\n First Name: "+userDTOJDBC.getFname()
						+ "\n Last Name: "+userDTOJDBC.getLname()
						+ "\n Email Id: "+userDTOJDBC.getEmailId()
						+ "\n Contact: "+userDTOJDBC.getContact()
						+ "\n Company: "+userDTOJDBC.getCompanyName()
						+ "\n Profession: "+userDTOJDBC.getProfessionName()
						+ "\n Education: "+userDTOJDBC.getEducationName()
								+ " \n\nHowever, you can always go back to the application and update your profile information whenever you want. "
								+ " \n\nIn case of any queries, you can reach out to us @apannu@hawk.iit.edu or just pass on your query through the Contact section.\n\nThanks and Regards,\nThought Warehouse");
			}

			Transport.send(mimeMessage);

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

	//method to create the otp
	public Integer createOTP() {
		Random rand = new Random();
		String id = String.format("%04d", rand.nextInt(10000));
		return Integer.parseInt(id);
	}

	//method to validate an email id format
	public boolean validateEmailId(String email){
		String regex = "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";
		 
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(email);
		
		if(matcher.matches())
			return true;
		else
			return false;
	}

}
