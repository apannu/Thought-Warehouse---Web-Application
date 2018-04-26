package com.iit.domain;

public class TopQuestions {
	
	private String question_name;
	private String questionName;
	private String answer_name;
	private String first_name;
	private String last_name;
	private String emailId;
	private Long contact;
	private String profession;
	private String company_name;
	private String education;
	private int userId;
	private int userIdQuestionValue;
	private String imageFlag;
	private int numberOfViews;
	
	public int getNumberOfViews() {
		return numberOfViews;
	}
	public void setNumberOfViews(int numberOfViews) {
		this.numberOfViews = numberOfViews;
	}
	public int getUserIdQuestionValue() {
		return userIdQuestionValue;
	}
	public void setUserIdQuestionValue(int userIdQuestionValue) {
		this.userIdQuestionValue = userIdQuestionValue;
	}
	public String getQuestionName() {
		return questionName;
	}
	public void setQuestionName(String questionName) {
		this.questionName = questionName;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getAnswer_name() {
		return answer_name;
	}
	public void setAnswer_name(String answer_name) {
		this.answer_name = answer_name;
	}
	public String getQuestion_name() {
		return question_name;
	}
	public void setQuestion_name(String question_name) {
		this.question_name = question_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public Long getContact() {
		return contact;
	}
	public void setContact(Long contact) {
		this.contact = contact;
	}
	public String getProfession() {
		return profession;
	}
	public void setProfession(String profession) {
		this.profession = profession;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getImageFlag() {
		return imageFlag;
	}
	public void setImageFlag(String imageFlag) {
		this.imageFlag = imageFlag;
	}
}