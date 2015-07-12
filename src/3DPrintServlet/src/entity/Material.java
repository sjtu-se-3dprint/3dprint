package entity;

import java.util.Date;

public class Material {

	private Integer id;
	private String name;
	private Float price;
	private Float accuracy;
	private Float intensity;
	private Float smooth;
	private String description;
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
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public Float getAccuracy() {
		return accuracy;
	}
	public void setAccuracy(Float accuracy) {
		this.accuracy = accuracy;
	}
	public Float getIntensity() {
		return intensity;
	}
	public void setIntensity(Float intensity) {
		this.intensity = intensity;
	}
	public Float getSmooth() {
		return smooth;
	}
	public void setSmooth(Float smooth) {
		this.smooth = smooth;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
