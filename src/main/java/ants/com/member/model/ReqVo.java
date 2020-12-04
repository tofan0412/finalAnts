package ants.com.member.model;

import ants.com.base.model.BaseVo;

public class ReqVo extends BaseVo{
	private String reqId;
	private String reqTitle;
	private String reqCont;
	private String reqPeriod;
	private String reqFilepath;
	private String reqFilename;
	private String memId;
	private String plId;
	private String status;
	private String plName;
	private String proPercent;
	private String proId;
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
	public String getPlName() {
		return plName;
	}
	public void setPlName(String plName) {
		this.plName = plName;
	}
	public String getProPercent() {
		return proPercent;
	}
	public void setProPercent(String proPercent) {
		this.proPercent = proPercent;
	}
	public String getProId() {
		return proId;
	}
	public void setProId(String proId) {
		this.proId = proId;
	}
	@Override
	public String toString() {
		return "ReqVo [reqId=" + reqId + ", reqTitle=" + reqTitle + ", reqCont=" + reqCont + ", reqPeriod=" + reqPeriod
				+ ", reqFilepath=" + reqFilepath + ", reqFilename=" + reqFilename + ", memId=" + memId + ", plId="
				+ plId + ", status=" + status + ", plName=" + plName + ", proPercent=" + proPercent + ", proId=" + proId
				+ "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((plId == null) ? 0 : plId.hashCode());
		result = prime * result + ((plName == null) ? 0 : plName.hashCode());
		result = prime * result + ((proId == null) ? 0 : proId.hashCode());
		result = prime * result + ((proPercent == null) ? 0 : proPercent.hashCode());
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
		if (!super.equals(obj))
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
		if (plName == null) {
			if (other.plName != null)
				return false;
		} else if (!plName.equals(other.plName))
			return false;
		if (proId == null) {
			if (other.proId != null)
				return false;
		} else if (!proId.equals(other.proId))
			return false;
		if (proPercent == null) {
			if (other.proPercent != null)
				return false;
		} else if (!proPercent.equals(other.proPercent))
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
