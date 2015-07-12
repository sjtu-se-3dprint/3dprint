package entity;

import java.util.Date;

public class Postsupport {
	
	private Integer id;
	private Post post;
	private User user;
	private Boolean support;
	private Date addtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Boolean getSupport() {
		return support;
	}
	public void setSupport(Boolean support) {
		this.support = support;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
}
