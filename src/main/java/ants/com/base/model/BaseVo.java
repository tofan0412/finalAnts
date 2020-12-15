/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package ants.com.base.model;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;


/**
 * @Class Name : SampleDefaultVO.java
 * @Description : SampleDefaultVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 *

 */
public class BaseVo implements Serializable {

	/**
	 *  serialVersion UID
	 */
	private static final long serialVersionUID = -858838578081269359L;

	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";
	
	/** 검색사용여부 */
	private String searchUseYn = "";
	
	/** 현재페이지 */
	private int pageIndex = 1;

	/** 페이지갯수 */
	private int pageUnit = 10;

	/** 페이지사이즈 */
	private int pageSize = 10;
	
	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;
	
	/** recordCountPerPage */
	private int recordCountPerPage = 10;
	
	

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + firstIndex;
		result = prime * result + lastIndex;
		result = prime * result + pageIndex;
		result = prime * result + pageSize;
		result = prime * result + pageUnit;
		result = prime * result + recordCountPerPage;
		result = prime * result + ((searchCondition == null) ? 0 : searchCondition.hashCode());
		result = prime * result + ((searchKeyword == null) ? 0 : searchKeyword.hashCode());
		result = prime * result + ((searchUseYn == null) ? 0 : searchUseYn.hashCode());
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
		BaseVo other = (BaseVo) obj;
		if (firstIndex != other.firstIndex)
			return false;
		if (lastIndex != other.lastIndex)
			return false;
		if (pageIndex != other.pageIndex)
			return false;
		if (pageSize != other.pageSize)
			return false;
		if (pageUnit != other.pageUnit)
			return false;
		if (recordCountPerPage != other.recordCountPerPage)
			return false;
		if (searchCondition == null) {
			if (other.searchCondition != null)
				return false;
		} else if (!searchCondition.equals(other.searchCondition))
			return false;
		if (searchKeyword == null) {
			if (other.searchKeyword != null)
				return false;
		} else if (!searchKeyword.equals(other.searchKeyword))
			return false;
		if (searchUseYn == null) {
			if (other.searchUseYn != null)
				return false;
		} else if (!searchUseYn.equals(other.searchUseYn))
			return false;
		return true;
	}
	
	


	
	
	
	
}
