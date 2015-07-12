package database;

public class MailService {
	public static MailServiceInterface getMailService(){
		return DB.getDB();
	}
}
