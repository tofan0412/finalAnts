package ants.com.file.model;

import java.util.Date;

public class PublicFileVo {
	
	
	private String PUB_ID;
	private String PUB_FILEPATH;
	private String PUB_FILENAME;
	private String PUB_EXTENSION;
	private Date REG_DT;
	private String CATEGORY_ID;
	private String SOME_ID;
	private String REQ_ID;
	private String PUB_SIZE;
	
	
	public String getPUB_ID() {
		return PUB_ID;
	}
	public void setPUB_ID(String pUB_ID) {
		PUB_ID = pUB_ID;
	}
	public String getPUB_FILEPATH() {
		return PUB_FILEPATH;
	}
	public void setPUB_FILEPATH(String pUB_FILEPATH) {
		PUB_FILEPATH = pUB_FILEPATH;
	}
	public String getPUB_FILENAME() {
		return PUB_FILENAME;
	}
	public void setPUB_FILENAME(String pUB_FILENAME) {
		PUB_FILENAME = pUB_FILENAME;
	}
	public String getPUB_EXTENSION() {
		return PUB_EXTENSION;
	}
	public void setPUB_EXTENSION(String pUB_EXTENSION) {
		PUB_EXTENSION = pUB_EXTENSION;
	}
	public Date getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(Date rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getCATEGORY_ID() {
		return CATEGORY_ID;
	}
	public void setCATEGORY_ID(String cATEGORY_ID) {
		CATEGORY_ID = cATEGORY_ID;
	}
	public String getSOME_ID() {
		return SOME_ID;
	}
	public void setSOME_ID(String sOME_ID) {
		SOME_ID = sOME_ID;
	}
	public String getREQ_ID() {
		return REQ_ID;
	}
	public void setREQ_ID(String rEQ_ID) {
		REQ_ID = rEQ_ID;
	}
	public String getPUB_SIZE() {
		return PUB_SIZE;
	}
	public void setPUB_SIZE(String pUB_SIZE) {
		PUB_SIZE = pUB_SIZE;
	}
	
	
	@Override
	public String toString() {
		return "PublicFileVo [PUB_ID=" + PUB_ID + ", PUB_FILEPATH=" + PUB_FILEPATH + ", PUB_FILENAME=" + PUB_FILENAME
				+ ", PUB_EXTENSION=" + PUB_EXTENSION + ", REG_DT=" + REG_DT + ", CATEGORY_ID=" + CATEGORY_ID
				+ ", SOME_ID=" + SOME_ID + ", REQ_ID=" + REQ_ID + ", PUB_SIZE=" + PUB_SIZE + "]";
	}
	
	
	
}
