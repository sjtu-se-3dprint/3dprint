package entity;

import java.util.Date;

public class Model {

	private Integer id;
	private String name;
	private Float length;
	private Float width;
	private Float height;
	private String style;
	private Integer collection;
	private Integer userlike;
	private Integer dislike;
	private String descriptrion;
	private Integer imageNumber;
	private Integer buy;
	private Integer download;
	private User user;
	private Boolean candown;
	private String status;
	private Date addtime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Float getLength() {
		return length;
	}
	public void setLength(Float length) {
		this.length = length;
	}
	public Float getWidth() {
		return width;
	}
	public void setWidth(Float width) {
		this.width = width;
	}
	public Float getHeight() {
		return height;
	}
	public void setHeight(Float height) {
		this.height = height;
	}
	public String getStyle() {
		return style;
	}
	public void setStyle(String style) {
		this.style = style;
	}
	public Integer getCollection() {
		return collection;
	}
	public void setCollection(Integer collection) {
		this.collection = collection;
	}
	public Integer getUserlike() {
		return userlike;
	}
	public void setUserlike(Integer userlike) {
		this.userlike = userlike;
	}
	public Integer getDislike() {
		return dislike;
	}
	public void setDislike(Integer dislike) {
		this.dislike = dislike;
	}
	public String getDescriptrion() {
		return descriptrion;
	}
	public void setDescriptrion(String descriptrion) {
		this.descriptrion = descriptrion;
	}
	public Integer getImageNumber() {
		return imageNumber;
	}
	public void setImageNumber(Integer imageNumber) {
		this.imageNumber = imageNumber;
	}
	public Integer getBuy() {
		return buy;
	}
	public void setBuy(Integer buy) {
		this.buy = buy;
	}
	public Integer getDownload() {
		return download;
	}
	public void setDownload(Integer download) {
		this.download = download;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Boolean getCandown() {
		return candown;
	}
	public void setCandown(Boolean candown) {
		this.candown = candown;
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
	
}
