package entity;

import java.util.Date;

public class Collection {
	private Integer id;
	private Integer userID;
	private Integer modelID;
	private Date addtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserID() {
		return userID;
	}
	public void setUserID(Integer userID) {
		this.userID = userID;
	}
	public Integer getModelID() {
		return modelID;
	}
	public void setModelID(Integer modelID) {
		this.modelID = modelID;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
}
