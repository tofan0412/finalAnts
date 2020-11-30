package ants.com.board.memBoard.model;

public class CategoryVo {
	
	
	private String categoryId;
	private String categoryName;
	private String categoryAuth;
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCategoryAuth() {
		return categoryAuth;
	}
	public void setCategoryAuth(String categoryAuth) {
		this.categoryAuth = categoryAuth;
	}
	@Override
	public String toString() {
		return "CategoryVo [categoryId=" + categoryId + ", categoryName=" + categoryName + ", categoryAuth="
				+ categoryAuth + "]";
	}
	
	
}
