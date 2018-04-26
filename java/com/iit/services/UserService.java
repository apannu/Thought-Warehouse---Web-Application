package com.iit.services;

import java.util.List;

import com.iit.domain.Blogs;
import com.iit.domain.Login;
import com.iit.domain.TopQuestions;
import com.iit.domain.UserDTO;

public interface UserService{
	
	 public boolean addUser(UserDTO userDTO);
	 public boolean saveQuestion(TopQuestions topQuestions);
	 public boolean saveAnswer(TopQuestions topQuestions);
	 public boolean saveComment(Blogs blogs);
	 public boolean updateUser(UserDTO userDTO, Long imageSize);
	 public String checkLogin(Login login);
	 public List<TopQuestions> getTopQuestions();
	 public List<Blogs> displayBlogs();
	 public UserDTO getFirstandLastName(String username);
	 public List<TopQuestions> getAnswers(String question);
	 public UserDTO getProfilePicture(int userId);
	 public UserDTO getProfileInformation(int userId);
	 public List<TopQuestions> getUserAskedQuestions(int userId);
	 public List<TopQuestions> getUsersAnswers(int userId);
	 public List<Blogs> getComments(String blogTopic);
	 public List<Blogs> getUserBlogInformation(String blogTopic);
	 public boolean saveBlog(Blogs blogs);
	 public List<Blogs> getUsersBlogs(int userId);
	 public List<Blogs> getCommentsBlogs(int userId);
	 public List<String> getAutoSuggestData(String autoSuggestString);
	 public String findSearchResults(String searchData);
	 public TopQuestions getSearchAnswer(String answer);
	 public int getUserId(String fname, String lname);
	 public boolean addFBUser(UserDTO userDTO, Long size);
	 public int checkFBUserId(String fname, String lname);
	 public boolean saveFbUserName(String fname, String lname);
	 public int getNumberOfViewsQuestion(String question);
	 public int getNumberOfViewsBlog(String blog);
	 public String updatePassword(UserDTO userDTO);
}