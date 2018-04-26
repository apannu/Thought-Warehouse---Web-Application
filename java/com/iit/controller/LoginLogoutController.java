package com.iit.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.iit.domain.Login;
import com.iit.domain.LoginForm;
import com.iit.domain.UserDTO;
import com.iit.services.UserService;

@Controller
public class LoginLogoutController {
	
	@Autowired
	private UserService userService;
	
	UserDTO userDTO = null;
	private boolean addFBRegisterStatus = true;
	
	final static Logger logger = Logger.getLogger(LoginLogoutController.class);
	
	UserDTO userDTOJDBC = new UserDTO();
    
    @RequestMapping("/login")
    public ModelAndView login(@ModelAttribute("login") Login login, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = new ModelAndView("login");
    	model1.addObject("login", new Login());
		return model1;
    }
    
    @RequestMapping("/loginPostQuestion")
    public ModelAndView loginForQuestion(@ModelAttribute("login") Login login, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = new ModelAndView("login");
    	model1.addObject("login", new Login());
    	model1.addObject("loginPostQuestionStatus", "Please login to post a new question.");
		return model1;
    }
    
    @RequestMapping("/loginPostAnswer")
    public ModelAndView loginForAnswer(@ModelAttribute("login") Login login, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = new ModelAndView("login");
    	model1.addObject("login", new Login());
    	model1.addObject("loginPostAnswerStatus", "Please login to post a new answer.");
		return model1;
    }
    
    @RequestMapping("/loginPostComment")
    public ModelAndView loginForComment(@ModelAttribute("login") Login login, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = new ModelAndView("login");
    	model1.addObject("login", new Login());
    	model1.addObject("loginPostCommentStatus", "Please login to post a new comment.");
		return model1;
    }
    
    @RequestMapping("/loginPostBlog")
    public ModelAndView loginForBlog(@ModelAttribute("login") Login login, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = new ModelAndView("login");
    	model1.addObject("login", new Login());
    	model1.addObject("loginPostBlogStatus", "Please login to post a new blog.");
		return model1;
    }
    
    @RequestMapping("/checkLogin")
    public ModelAndView checkLogin(@ModelAttribute("login") Login login, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model = null;
    	try
    	{
	    	String loginStatus = userService.checkLogin(login);
	    	if(loginStatus.equals("success"))
	    	{
	    		model = new ModelAndView("welcomePage");
	    		HttpSession httpSession = request.getSession(true);
	    			httpSession.setAttribute("username", login.getUsername());
		        	System.out.println("session value is: "+httpSession.getAttribute("username"));
	        	
	        	userDTO = userService.getFirstandLastName(login.getUsername());
	        	httpSession.setAttribute("firstName", userDTO.getFname());
	        	httpSession.setAttribute("lastName", userDTO.getLname());
    			httpSession.setAttribute("userId", Integer.toString(userDTO.getUserId()));
    			httpSession.setAttribute("imageFlag", userDTO.getImageFlag());
	        	model.addObject("userId", userDTO.getUserId());
	    		model.addObject("firstAndLastName", userDTO.getFname()+" "+userDTO.getLname());
	    	}
	    	else
	    	{
	    		model = new ModelAndView("login");
	    		model.addObject("loginStatus", "Your credentials do not match or it could in the wrong case. Please try again!");
	    	}
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to check the login credentials."+e.getMessage());
    	}
		return model;
    }
    
    @RequestMapping(value = "/fbRegister", method = RequestMethod.POST)
    public ModelAndView displayTopQuestions(@ModelAttribute("userDTO") UserDTO userDTO, BindingResult result,
    		@RequestParam("profilePic") MultipartFile file,HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
    		userDTO.setProfilePic(file.getBytes());
    		addFBRegisterStatus = userService.addFBUser(userDTO, file.getSize());
    		
    		int userId = userService.getUserId(userDTO.getFbProfileName().split(" ")[0], userDTO.getFbProfileName().split(" ")[1]);
	    	
	    	if(addFBRegisterStatus)
	    	{
	    		model1 = new ModelAndView("welcomePage");
	    		model1.addObject("fbSignupStatus", "Hello "+userDTO.getFbProfileName()+"! Your profile has been updated successfully. An email has been sent to "+userDTO.getFbEmailId()+ " for your confirmation.");
	    		HttpSession httpSession = request.getSession(false);
	    		httpSession.setAttribute("fbUsername", userDTO.getFbProfileName());
	    		httpSession.setAttribute("fbUserId", Integer.toString(userId));
	        	System.out.println("FB session value is: "+httpSession.getAttribute("fbUsername"));
	    	}
	    	else 
	    	{
	    		model1 = new ModelAndView("welcomePage");
	    		model1.addObject("fbRegisterStatus", "An error occured while trying to update your profile through Facebook. Please update your information in your profile section.");
	    	}
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to update a fb user."+e.getMessage());
    	}
		return model1;
    }
    
    @ResponseBody
    @RequestMapping(value = "/checkFBUser", method = RequestMethod.POST)
    public String displayUserAskedQuestions( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("fbName") String fbName)
    {
    	int fbUserId= 0 ;
    	try
    	{
    		fbUserId = userService.checkFBUserId(fbName.split(" ")[0], fbName.split(" ")[1]);
    		HttpSession httpSession = request.getSession(false);
    		httpSession.setAttribute("fbUsername", fbName);
    		httpSession.setAttribute("fbUserId", Integer.toString(fbUserId));
        	System.out.println("FB session value is: "+httpSession.getAttribute("fbUsername"));
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to return the model view "
    				+ "with the list of top questions."+e.getStackTrace());
    	}
		return Integer.toString(fbUserId);
    }
    
    @ResponseBody
    @RequestMapping(value = "/saveFBUserName", method = RequestMethod.POST)
    public String saveFBUserName( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("fbName") String fbName)
    {
    	int fbUserId = 0;
    	try
    	{
    		addFBRegisterStatus = userService.saveFbUserName(fbName.split(" ")[0], fbName.split(" ")[1]);
    		if(addFBRegisterStatus)
    		{
    			fbUserId = userService.checkFBUserId(fbName.split(" ")[0], fbName.split(" ")[1]);
	    		HttpSession httpSession = request.getSession(false);
	    		httpSession.setAttribute("fbUsername", fbName);
	    		httpSession.setAttribute("fbUserId", Integer.toString(fbUserId));
	        	System.out.println("FB session value is: "+httpSession.getAttribute("fbUsername"));
    		}
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to return the model view "
    				+ "with the list of top questions."+e.getStackTrace());
    	}
		return Integer.toString(fbUserId);
    }
    
    @RequestMapping("/logout")
    public ModelAndView logout(@ModelAttribute("login") Login login, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model = null;
    		model = new ModelAndView("welcomePage");
    		model.addObject("logoutStatus", "You have been successfully logged out of the application.");
		return model;
    }
    
    
    @RequestMapping("/signup")
    public ModelAndView signUp(HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = new ModelAndView("register");
    	model1.addObject("loginForm", new LoginForm());
		return model1;
    }
}