package ants.com.member.model;

import ants.com.common.model.PageVO;

public class ReqVo extends PageVO{
	
	
	private String reqId;
	private String reqTitle;
	private String reqCont;
	private String reqPeriod;
	private String reqFilepath;
	private String reqFilename;
	private String memId;
	private String plId;
	private String status;
	
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getReqTitle() {
		return reqTitle;
	}
	public void setReqTitle(String reqTitle) {
		this.reqTitle = reqTitle;
	}
	public String getReqCont() {
		return reqCont;
	}
	public void setReqCont(String reqCont) {
		this.reqCont = reqCont;
	}
	public String getReqPeriod() {
		return reqPeriod;
	}
	public void setReqPeriod(String reqPeriod) {
		this.reqPeriod = reqPeriod;
	}
	public String getReqFilepath() {
		return reqFilepath;
	}
	public void setReqFilepath(String reqFilepath) {
		this.reqFilepath = reqFilepath;
	}
	public String getReqFilename() {
		return reqFilename;
	}
	public void setReqFilename(String reqFilename) {
		this.reqFilename = reqFilename;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPlId() {
		return plId;
	}
	public void setPlId(String plId) {
		this.plId = plId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "ReqVo [reqId=" + reqId + ", reqTitle=" + reqTitle + ", reqCont=" + reqCont + ", reqPeriod=" + reqPeriod
				+ ", reqFilepath=" + reqFilepath + ", reqFilename=" + reqFilename + ", memId=" + memId + ", plId="
				+ plId + ", status=" + status + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((plId == null) ? 0 : plId.hashCode());
		result = prime * result + ((reqCont == null) ? 0 : reqCont.hashCode());
		result = prime * result + ((reqFilename == null) ? 0 : reqFilename.hashCode());
		result = prime * result + ((reqFilepath == null) ? 0 : reqFilepath.hashCode());
		result = prime * result + ((reqId == null) ? 0 : reqId.hashCode());
		result = prime * result + ((reqPeriod == null) ? 0 : reqPeriod.hashCode());
		result = prime * result + ((reqTitle == null) ? 0 : reqTitle.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReqVo other = (ReqVo) obj;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (plId == null) {
			if (other.plId != null)
				return false;
		} else if (!plId.equals(other.plId))
			return false;
		if (reqCont == null) {
			if (other.reqCont != null)
				return false;
		} else if (!reqCont.equals(other.reqCont))
			return false;
		if (reqFilename == null) {
			if (other.reqFilename != null)
				return false;
		} else if (!reqFilename.equals(other.reqFilename))
			return false;
		if (reqFilepath == null) {
			if (other.reqFilepath != null)
				return false;
		} else if (!reqFilepath.equals(other.reqFilepath))
			return false;
		if (reqId == null) {
			if (other.reqId != null)
				return false;
		} else if (!reqId.equals(other.reqId))
			return false;
		if (reqPeriod == null) {
			if (other.reqPeriod != null)
				return false;
		} else if (!reqPeriod.equals(other.reqPeriod))
			return false;
		if (reqTitle == null) {
			if (other.reqTitle != null)
				return false;
		} else if (!reqTitle.equals(other.reqTitle))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		return true;
	}
	
	
	
	
	
}
