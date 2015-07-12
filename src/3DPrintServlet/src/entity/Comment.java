package entity;

import java.util.Date;

public class Comment {

	private Integer id;
	private String comment;
	private Model model;
	private User user;
	private String status;
	private Date addtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Model getModel() {
		return model;
	}
	public void setModel(Model model) {
		this.model = model;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public String toJSON(){
		StringBuilder builder = new StringBuilder();
		builder.append("{");
		builder.append(util.Util.quotation("id") + ":" + id + ",");
		builder.append(util.Util.quotation("userID") + ":" + user.getId() + ",");
		builder.append(util.Util.quotation("modelID") + ":" + model.getId() + ",");
		builder.append(util.Util.quotation("addtime") + ":" + util.Util.quotation(addtime.toString()) + ",");
		builder.append(util.Util.quotation("comment") + ":" + util.Util.quotation(comment) + ",");
		builder.append(util.Util.quotation("status") + ":" + util.Util.quotation(status) + ",");
		builder.append(util.Util.quotation("userName") + ":" + util.Util.quotation(user.getName()));
		builder.append("}");
		return builder.toString();
	}
}
