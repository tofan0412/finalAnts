package ants.com.board.memBoard.model;

public class CategoryVo {
	
	
	private String category_id;
	private String category_name;
	private String category_auth;
	
	
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getCategory_auth() {
		return category_auth;
	}
	public void setCategory_auth(String category_auth) {
		this.category_auth = category_auth;
	}
	
	
	@Override
	public String toString() {
		return "CategoryVo [category_id=" + category_id + ", category_name=" + category_name + ", category_auth="
				+ category_auth + "]";
	}
	
	
}
