package entity;

import java.util.Date;

public class Mail {
	private Integer id;
	private Integer senderID;
	private Integer receiverID;
	private String title;
	private String content;
	private Boolean isRead;
	private Date addtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSenderID() {
		return senderID;
	}
	public void setSenderID(Integer senderID) {
		this.senderID = senderID;
	}
	public Integer getReceiverID() {
		return receiverID;
	}
	public void setReceiverID(Integer receiverID) {
		this.receiverID = receiverID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Boolean getIsRead() {
		return isRead;
	}
	public void setIsRead(Boolean isRead) {
		this.isRead = isRead;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	
}
