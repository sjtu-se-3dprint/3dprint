package database;

import java.util.List;

import entity.Mail;

public interface MailServiceInterface {

	public Boolean addMail(int senderID, int receiverID, String title, String content);
	
	public List<Mail> selectMails(int receiverID, boolean isRead);
	
	public Boolean changeReadStatus(int mailID, boolean isRead);
}
