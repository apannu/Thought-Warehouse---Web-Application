package com.iit.domain;

public class UserDTO {
	
	private int userId;
	
	private int fbUserId;
	
	private int userIdResetPasswordValue;

	private String username;
	
	private String password;
	
	private String newPassword;
	
	private String active_Flg;
	
	private String fname;
	
	private String lname;
	
	private String emailId;
	
	private Long contact;
	
	private int tw_userdetails_id;
	
	private String professionName;
	
	private String companyName;
	
	private String educationName;
	
	private byte[] profilePic;
	
	private String imageFlag;
	
	private String fbProfileName;
	
	private Long fbContact;
	
	private String fbEmailId;
	
	public int getUserIdResetPasswordValue() {
		return userIdResetPasswordValue;
	}

	public void setUserIdResetPasswordValue(int userIdResetPasswordValue) {
		this.userIdResetPasswordValue = userIdResetPasswordValue;
	}

	public UserDTO()
	{
		
	}

	public UserDTO(String username, String password, String fname, String lname, String emailId,
			Long contact, String professionName, String companyName, String educationName, byte[] profilePic) {
		super();
		this.username = username;
		this.password = password;
		this.fname = fname;
		this.lname = lname;
		this.emailId = emailId;
		this.contact = contact;
		this.professionName = professionName;
		this.companyName = companyName;
		this.educationName = educationName;
		this.profilePic = profilePic;
	}
	
	public UserDTO(int userId, String fname, String lname, String emailId,
			Long contact, String professionName, String companyName, String educationName, byte[] profilePic) {
		super();
		this.userId = userId;
		this.fname = fname;
		this.lname = lname;
		this.emailId = emailId;
		this.contact = contact;
		this.professionName = professionName;
		this.companyName = companyName;
		this.educationName = educationName;
		this.profilePic = profilePic;
	}
	
	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public int getFbUserId() {
		return fbUserId;
	}

	public void setFbUserId(int fbUserId) {
		this.fbUserId = fbUserId;
	}

	public String getFbProfileName() {
		return fbProfileName;
	}

	public void setFbProfileName(String fbProfileName) {
		this.fbProfileName = fbProfileName;
	}

	public Long getFbContact() {
		return fbContact;
	}

	public void setFbContact(Long fbContact) {
		this.fbContact = fbContact;
	}

	public String getFbEmailId() {
		return fbEmailId;
	}

	public void setFbEmailId(String fbEmailId) {
		this.fbEmailId = fbEmailId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getActive_Flg() {
		return active_Flg;
	}

	public void setActive_Flg(String active_Flg) {
		this.active_Flg = active_Flg;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
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

	public int getTw_userdetails_id() {
		return tw_userdetails_id;
	}

	public void setTw_userdetails_id(int tw_userdetails_id) {
		this.tw_userdetails_id = tw_userdetails_id;
	}

	public String getProfessionName() {
		return professionName;
	}

	public void setProfessionName(String professionName) {
		this.professionName = professionName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getEducationName() {
		return educationName;
	}

	public void setEducationName(String educationName) {
		this.educationName = educationName;
	}

	public byte[] getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(byte[] profilePic) {
		this.profilePic = profilePic;
	}

	public String getImageFlag() {
		return imageFlag;
	}

	public void setImageFlag(String imageFlag) {
		this.imageFlag = imageFlag;
	}
}
