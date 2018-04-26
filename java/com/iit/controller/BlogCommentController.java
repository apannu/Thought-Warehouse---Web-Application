package com.iit.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.iit.domain.Blogs;
import com.iit.domain.TopQuestions;
import com.iit.domain.UserDTO;
import com.iit.services.UserService;

@Controller
public class BlogCommentController {
	
	@Autowired
	private UserService userService;
	
	private boolean addCommentStatus = true;
	private boolean addBlogStatus = true;
	private int commentCount;
	UserDTO userDTO = null;
	
	final static Logger logger = Logger.getLogger(BlogCommentController.class);
	
	UserDTO userDTOJDBC = new UserDTO();
    
    @ResponseBody
    @RequestMapping(value="/getProfileForAnswers", method = RequestMethod.POST)
    public String getProfileForAnswers( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	String json = "[]";
    	List<UserDTO> list = new ArrayList<UserDTO>();
    	try
    	{
    		userDTO = userService.getProfileInformation(userId);
    		list.add(userDTO);
    		
    		if(list!=null)
        		json = getJsonString(list);
        	StringBuffer sb = new StringBuffer("{\"items\":");
			sb.append(json);
			sb.append("}");		
			json =  sb.toString();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to load the user profile to write answers."+e);
    	}
		return json;
    }
    
    @RequestMapping("/saveBlog")
    public ModelAndView saveBlog(@ModelAttribute("blogs") Blogs blogs, BindingResult result, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
    		
    		addBlogStatus = userService.saveBlog(blogs);
	    	
	    	if(addBlogStatus)
	    	{
	    		model1 = new ModelAndView("welcomePage");
	    		model1.addObject("saveBlogSuccessStatus", "Your blog has been posted successfully.");
	    	}
	    	else
	    	{
	    		model1 = new ModelAndView("welcomePage");
	    		model1.addObject("saveBlogErrorStatus", "An error occured while trying to post a new blog. Please try again.");
	    	}
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to add a blog."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/getBlogs")
    public ModelAndView getBlogs(HttpServletRequest request, HttpServletResponse response, @RequestParam("blogTopic") String blogTopic)
    {
    	int numberOfViews = 0;
    	ModelAndView model1 = null;
    	String json = "[]";
    	try
    	{
    		    commentCount = 0;
	    		model1 = new ModelAndView("getBlogs");
	    		List<Blogs> list = null;
	    		list = userService.getComments(blogTopic);
	    		numberOfViews = userService.getNumberOfViewsBlog(blogTopic);
	    		commentCount = list.size();
	        	if(commentCount!=0)
	        		json = getJsonString(list);
	        	StringBuffer sb = new StringBuffer("{\"items\":");
				sb.append(json);
				sb.append("}");		
				json =  sb.toString();
				model1.addObject("json", json);
				model1.addObject("blogTopic", blogTopic);
				model1.addObject("commentCount", commentCount);
				model1.addObject("numberOfViews", numberOfViews);
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the comments for a particular blog."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/saveComment", method = RequestMethod.POST)
    public ModelAndView saveComment(@ModelAttribute("commentForm") Blogs blogs, BindingResult result, HttpServletRequest request, HttpServletResponse response)
    {
    	int numberOfViews = 0;
    	ModelAndView model1 = null;
    	String json = "[]";
    	try
    	{
    			//to save the comment
    		    addCommentStatus = userService.saveComment(blogs);
    		    
    		    //to display the blog and comments
    		    commentCount = 0;
	    		model1 = new ModelAndView("getBlogs");
	    		List<Blogs> list = null;
	    		list = userService.getComments(blogs.getBlogTopic1());
	    		numberOfViews = userService.getNumberOfViewsBlog(blogs.getBlogTopic1());
	    		commentCount = list.size();
	        	if(commentCount!=0)
	        		json = getJsonString(list);
	        	StringBuffer sb = new StringBuffer("{\"items\":");
				sb.append(json);
				sb.append("}");		 
				json =  sb.toString();
				model1.addObject("json", json);
				model1.addObject("blogTopic", blogs.getBlogTopic1());
				model1.addObject("commentCount", commentCount);
				model1.addObject("numberOfViews", numberOfViews);
				
    		    if(addCommentStatus)
	    		    
					model1.addObject("commentSuccessStatus", "Your comment was successfully posted.");
    		    else
    		    	model1.addObject("commentErrorStatus", "An error occured while trying to post a comment. Please try again.");
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to save a comment and refresh the comments."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/displayBlogPageForUsers")
    public ModelAndView displayBlogPageForUsers(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam("userId") int userId)
    {
    	ModelAndView model1 = null;
    	try
    	{
	    		model1 = new ModelAndView("displayBlogsForUsers");
	    		model1.addObject("userId", userId);
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the blogs page for other users."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/displayBlogPage")
    public ModelAndView displayBlogPage(HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
	    		model1 = new ModelAndView("displayBlogs");
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the blogs page for logged in user."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/displayCommentPageForUsers")
    public ModelAndView displayCommentPageForUsers(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam("userId") int userId)
    {
    	ModelAndView model1 = null;
    	try
    	{
	    		model1 = new ModelAndView("displayCommentsForUsers");
	    		model1.addObject("userId", userId);
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the comments page for other users."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/displayCommentPage")
    public ModelAndView displayCommentPage(HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
	    		model1 = new ModelAndView("displayComments");
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the comments page for logged in user."+e.getMessage());
    	}
		return model1;
    }
    
    @ResponseBody
    @RequestMapping(value = "/displayBlogs", method = RequestMethod.POST)
    public String displayBlogs( 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	String json = "[]";
    	List<Blogs> list = new ArrayList<Blogs>();
    	try
    	{
    		list = userService.displayBlogs();
        	if(list!=null)
        		json = getJsonString(list);
        	StringBuffer sb = new StringBuffer("{\"items\":");
			sb.append(json);
			sb.append("}");		
			json =  sb.toString();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to return the model view "
    				+ "with the list of top blogs."+e.getStackTrace());
    	}
		return json;
    }
    
    @ResponseBody
    @RequestMapping(value = "/displayUserInformationForBlogs", method = RequestMethod.POST)
    public String displayUserInformationForBlogs( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("blogTopic") String blogTopic)
    {
    	String json = "[]";
    	List<Blogs> list = new ArrayList<Blogs>();
    	try
    	{
    		list = userService.getUserBlogInformation(blogTopic);
        	if(list!=null)
        		json = getJsonString(list);
        	StringBuffer sb = new StringBuffer("{\"items\":");
			sb.append(json);
			sb.append("}");		
			json =  sb.toString();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to return the model view "
    				+ "with the use information who has written the blog."+e.getStackTrace());
    	}
		return json;
    }
    
    @ResponseBody
    @RequestMapping(value = "/userBlogs", method = RequestMethod.POST)
    public String displayUserBlogs( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	String json = "[]";
    	List<Blogs> list = new ArrayList<Blogs>();
    	try
    	{
    		list = userService.getUsersBlogs(userId);
        	if(list!=null)
        		json = getJsonString(list);
        	StringBuffer sb = new StringBuffer("{\"items\":");
			sb.append(json);
			sb.append("}");		
			json =  sb.toString();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying get the blogs that user has posted. "+e.getStackTrace());
    	}
		return json;
    }
    
    @ResponseBody
    @RequestMapping(value = "/userComments", method = RequestMethod.POST)
    public String displayUserComments( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	String json = "[]";
    	List<Blogs> list = new ArrayList<Blogs>();
    	try
    	{
    		list = userService.getCommentsBlogs(userId);
        	if(list!=null)
        		json = getJsonString(list);
        	StringBuffer sb = new StringBuffer("{\"items\":");
			sb.append(json);
			sb.append("}");		
			json =  sb.toString();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying get the comments that user has posted. "+e.getStackTrace());
    	}
		return json;
    }
    
    @ResponseBody
    @RequestMapping(value = "/profileAnswers", method = RequestMethod.POST)
    public String getProfileAnswers( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	String json = "[]";
    	List<TopQuestions> list = new ArrayList<TopQuestions>();
    	try
    	{
    		userDTO = userService.getProfileInformation(userId);
    		TopQuestions topQuestions = new TopQuestions();
    		topQuestions.setFirst_name(userDTO.getFname());
    		topQuestions.setLast_name(userDTO.getLname());
    		topQuestions.setEmailId(userDTO.getEmailId());
    		topQuestions.setContact(userDTO.getContact());
    		topQuestions.setProfession(userDTO.getProfessionName());
    		topQuestions.setCompany_name(userDTO.getCompanyName());
    		topQuestions.setEducation(userDTO.getEducationName());
    		topQuestions.setUserId(userDTO.getUserId());
    		topQuestions.setImageFlag(userDTO.getImageFlag());
    		
    		list.add(topQuestions);
    		
        	if(list!=null)
        		json = getJsonString(list);
        	StringBuffer sb = new StringBuffer("{\"items\":");
			sb.append(json);
			sb.append("}");		
			json =  sb.toString();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to return the model view "
    				+ "with the list of top questions."+e.getStackTrace());
    	}
		return json;
    }
    
    private String getJsonString(@SuppressWarnings("rawtypes") List list) {
    	Gson gson = new Gson();
		String json;
		json = gson.toJson(list);
		return json;
	}
}