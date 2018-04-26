
package com.iit.services;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.iit.dao.UserDao;
import com.iit.domain.Blogs;
import com.iit.domain.Login;
import com.iit.domain.TopQuestions;
import com.iit.domain.UserDTO;
import com.iit.services.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
    private UserDao userDao;
	
    @Transactional
    public boolean addUser(UserDTO userDTO) {
        return userDao.addUser(userDTO);
    }
    
    @Transactional
    public boolean updateUser(UserDTO userDTO, Long imageSize) {
        return userDao.updateUser(userDTO, imageSize);
    }
    
    @Transactional
    public List<TopQuestions> getAnswers(String question){
    	return userDao.getAnswers(question);
    }
    
    @Transactional
    public String checkLogin(Login login) {
        return userDao.checkLogin(login);
    }
    
    @Transactional
    public List<TopQuestions> getTopQuestions()
    {
    	return userDao.getTopQuestions();
    }
    
    @Transactional
    public UserDTO getFirstandLastName(String username)
    {
    	return userDao.getFirstandLastName(username);
    }
    
    @Transactional
    public UserDTO getProfilePicture(int userId)
    {
    	return userDao.getProfilePicture(userId);
    }
    
    @Transactional
    public UserDTO getProfileInformation(int userId)
    {
    	return userDao.getProfileInformation(userId);
    }
    
    @Transactional
    public List<TopQuestions> getUserAskedQuestions(int userId)
    {
    	return userDao.getUserAskedQuestions(userId);
    }
    
    @Transactional
    public List<TopQuestions> getUsersAnswers(int userId)
    {
    	return userDao.getUsersAnswers(userId);
    }
    
    @Transactional
    public boolean saveQuestion(TopQuestions topQuestions)
    {
    	return userDao.saveQuestion(topQuestions);
    }
    
    @Transactional
    public boolean saveAnswer(TopQuestions topQuestions)
    {
    	return userDao.saveAnswer(topQuestions);
    }
    
    @Transactional
    public List<Blogs> displayBlogs()
    {
    	return userDao.displayBlogs();
    }
    
    @Transactional
    public List<Blogs> getComments(String blogTopic)
    {
    	return userDao.getComments(blogTopic);
    }
    
    @Transactional
    public List<Blogs> getUserBlogInformation(String blogTopic)
    {
    	return userDao.getUserBlogInformation(blogTopic);
    }
    
    @Transactional
    public boolean saveComment(Blogs blogs)
    {
    	return userDao.saveComment(blogs);
    }
    
    @Transactional
    public boolean saveBlog(Blogs blogs)
    {
    	return userDao.saveBlog(blogs);
    }
    
    @Transactional
    public List<Blogs> getUsersBlogs(int userId)
    {
    	return userDao.getUsersBlogs(userId);
    }
    
    @Transactional
    public List<Blogs> getCommentsBlogs(int userId)
    {
    	return userDao.getCommentsBlogs(userId);
    }
    
    @Transactional
    public List<String> getAutoSuggestData(String autoSuggestString)
    {
    	return userDao.getAutoSuggestData(autoSuggestString);
    }
    
    @Transactional
    public String findSearchResults(String searchData)
    {
    	return userDao.findSearchResults(searchData);
    }
    
    @Transactional
    public TopQuestions getSearchAnswer(String answer)
    {
    	return userDao.getSearchAnswer(answer);
    }
    
    @Transactional
    public int getUserId(String fname, String lname)
    {
    	return userDao.getUserId(fname, lname);
    }
    
    @Transactional
    public boolean addFBUser(UserDTO userDTO, Long size)
    {
    	return userDao.addFBUser(userDTO, size);
    }
    
    @Transactional
    public int checkFBUserId(String fname, String lname)
    {
    	return userDao.checkFBUserId(fname, lname);
    }
    
    @Transactional
    public boolean saveFbUserName(String fname, String lname)
    {
    	return userDao.saveFbUserName(fname, lname);
    }
    
    @Transactional
    public int getNumberOfViewsQuestion(String question)
    {
    	return userDao.getNumberOfViewsQuestion(question);
    }
    
    @Transactional
    public int getNumberOfViewsBlog(String blog)
    {
    	return userDao.getNumberOfViewsBlog(blog);
    }
    
    @Transactional
    public String updatePassword(UserDTO userDTO)
    {
    	return userDao.updatePassword(userDTO);
    }
}