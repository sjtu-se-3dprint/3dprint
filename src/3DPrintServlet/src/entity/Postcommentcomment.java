package entity;

import java.util.Date;

public class Postcommentcomment {
	private Integer id;
	private Postcomment postcomment;
	private User user;
	private String content;
	private Integer floor;
	private Date addtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Postcomment getPostcomment() {
		return postcomment;
	}
	public void setPostcomment(Postcomment postcomment) {
		this.postcomment = postcomment;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getFloor() {
		return floor;
	}
	public void setFloor(Integer floor) {
		this.floor = floor;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
}
