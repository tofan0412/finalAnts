package ants.com.file.model;

import ants.com.base.model.BaseVo;

public class PublicFileVo extends BaseVo {
	
	private String pubId;
	private String pubFilepath;
	private String pubFilename;
	private String pubExtension;
	private String regDt;
	private String categoryId;
	private String someId;
	private String reqId;
	private String pubSize;
	private String memId;
	private String sort;
	
	public PublicFileVo() {
		
	}
	public PublicFileVo(String categoryId, String someId, String reqId) {
		super();
		this.categoryId = categoryId;
		this.someId = someId;
		this.reqId = reqId;
	}

	public PublicFileVo(String pubFilepath, String pubFilename, String pubExtension, String categoryId, String someId,
			String reqId, String pubSize, String memId) {
		super();
		this.pubFilepath = pubFilepath;
		this.pubFilename = pubFilename;
		this.pubExtension = pubExtension;
		this.categoryId = categoryId;
		this.someId = someId;
		this.reqId = reqId;
		this.pubSize = pubSize;
		this.memId = memId;
	}
	
	
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getPubId() {
		return pubId;
	}
	public void setPubId(String pubId) {
		this.pubId = pubId;
	}
	public String getPubFilepath() {
		return pubFilepath;
	}
	public void setPubFilepath(String pubFilepath) {
		this.pubFilepath = pubFilepath;
	}
	public String getPubFilename() {
		return pubFilename;
	}
	public void setPubFilename(String pubFilename) {
		this.pubFilename = pubFilename;
	}
	public String getPubExtension() {
		return pubExtension;
	}
	public void setPubExtension(String pubExtension) {
		this.pubExtension = pubExtension;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getSomeId() {
		return someId;
	}
	public void setSomeId(String someId) {
		this.someId = someId;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getPubSize() {
		return pubSize;
	}
	public void setPubSize(String pubSize) {
		this.pubSize = pubSize;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	@Override
	public String toString() {
		return "PublicFileVo [pubId=" + pubId + ", pubFilepath=" + pubFilepath + ", pubFilename=" + pubFilename
				+ ", pubExtension=" + pubExtension + ", regDt=" + regDt + ", categoryId=" + categoryId + ", someId="
				+ someId + ", reqId=" + reqId + ", pubSize=" + pubSize + ", memId=" + memId + "]";
	}
	
	
	
	
	
	
}
