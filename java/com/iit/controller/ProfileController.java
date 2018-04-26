package com.iit.controller;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.iit.domain.LoginForm;
import com.iit.domain.UserDTO;
import com.iit.services.UserService;

@Controller
public class ProfileController {
	
	@Autowired
	private UserService userService;
	
	private boolean addUserStatus = true;
	private boolean updateUserStatus = true;
	UserDTO userDTO = null;
	
	final static Logger logger = Logger.getLogger(ProfileController.class);
	
	UserDTO userDTOJDBC = new UserDTO();
	
    @RequestMapping("/editProfile")
    public ModelAndView editProfile( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	ModelAndView model = null;
    	try
    	{
    		model = new ModelAndView("editProfile");
    		userDTO = userService.getProfileInformation(userId);
    		model.addObject("fname", userDTO.getFname());
    		model.addObject("lname", userDTO.getLname());
    		model.addObject("emailId", userDTO.getEmailId());
    		model.addObject("contact", userDTO.getContact());
    		model.addObject("professionName", userDTO.getProfessionName());
    		model.addObject("companyName", userDTO.getCompanyName());
    		model.addObject("educationName", userDTO.getEducationName());
    		model.addObject("userId", userDTO.getUserId());
    		model.addObject("imageFlag", userDTO.getImageFlag());
    	}
    	catch(Exception e)
    	{
    		System.out.println("An excception occured while trying to load the user profile."+e);
    	}
		return model;
    }
    
    @RequestMapping("/updatePassword")
    public ModelAndView updatePassword(@ModelAttribute("userDTO") UserDTO userDTO1, BindingResult result,
    		HttpServletRequest request, HttpServletResponse response)
    {
    	String updatePasswordStatus = "";
    	ModelAndView model = null;
    	
    	UserDTO userDTO = null;
    	
    	try
    	{
    		userDTO = userService.getProfileInformation(userDTO1.getUserIdResetPasswordValue());
    		model = new ModelAndView("editProfile");
    		model.addObject("fname", userDTO.getFname());
    		model.addObject("lname", userDTO.getLname());
    		model.addObject("emailId", userDTO.getEmailId());
    		model.addObject("contact", userDTO.getContact());
    		model.addObject("professionName", userDTO.getProfessionName());
    		model.addObject("companyName", userDTO.getCompanyName());
    		model.addObject("educationName", userDTO.getEducationName());
    		model.addObject("userId", userDTO.getUserId());
    		model.addObject("imageFlag", userDTO.getImageFlag());
    		
    		userDTO1.setFname(userDTO.getFname());
    		userDTO1.setLname(userDTO.getLname());
    		userDTO1.setEmailId(userDTO.getEmailId());
    		
    		updatePasswordStatus = userService.updatePassword(userDTO1);
    		if(updatePasswordStatus!="")
    			model.addObject("updatePasswordStatus", updatePasswordStatus);
    	}
    	catch(Exception e)
    	{
    		System.out.println("An excception occured while trying to update the password."+e);
    	}
		return model;
    }
    
    @RequestMapping("/show")
    public ModelAndView displayWelcomePage( 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model = null;
    		model = new ModelAndView("welcomePage");
		return model;
    }
    
    @RequestMapping("/profile")
    public ModelAndView displayUserProfile( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	ModelAndView model = null;
    	try
    	{
    		model = new ModelAndView("displayProfile");
    		userDTO = userService.getProfileInformation(userId);
    		model.addObject("fname", userDTO.getFname());
    		model.addObject("lname", userDTO.getLname());
    		model.addObject("emailId", userDTO.getEmailId());
    		model.addObject("contact", userDTO.getContact());
    		model.addObject("professionName", userDTO.getProfessionName());
    		model.addObject("companyName", userDTO.getCompanyName());
    		model.addObject("educationName", userDTO.getEducationName());
    		model.addObject("userId", userDTO.getUserId());
    		model.addObject("imageFlag", userDTO.getImageFlag());
    	}
    	catch(Exception e)
    	{
    		System.out.println("An excception occured while trying to load the user profile."+e);
    	}
		return model;
    }
    
    @RequestMapping("/profilePic")
    public ModelAndView displayProfilePic( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	ModelAndView model = null;
    	try
    	{
    		model = new ModelAndView("displayProfile");
    		userDTO = userService.getProfilePicture(userId);
    		 response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
    		    response.getOutputStream().write(userDTO.getProfilePic());

    		    response.getOutputStream().close();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An excception occured while trying to get the image in controller."+e);
    	}
		return model;
    }
//    
//    private String getJsonString(@SuppressWarnings("rawtypes") List list) {
//    	Gson gson = new Gson();
//		String json;
//		json = gson.toJson(list);
//		return json;
//	}
//    
//    @ResponseBody
//    @RequestMapping(value = "/getUserId", method = RequestMethod.POST)
//    public String displayTopQuestions( 
//    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userName") String userName)
//    {
//    	String json = "[]";
//    	int userId = 0;
//    	TopQuestions topQuestions = new TopQuestions();
//    	List<TopQuestions> list = new ArrayList<TopQuestions>();
//    	try
//    	{
//    		userId = userService.getUserId(userName.split(" ")[0], userName.split(" ")[1]);
//    		topQuestions.setUserId(userId);
//    		list.add(topQuestions);
//        	if(list!=null)
//        		json = getJsonString(list);
//        	StringBuffer sb = new StringBuffer("{\"items\":");
//			sb.append(json);
//			sb.append("}");		
//			json =  sb.toString();
//    	}
//    	catch(Exception e)
//    	{
//    		System.out.println("An exception occured while trying to return the userid using the first and last name"+e.getMessage());
//    	}
//		return json;
//    }
    
    
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView register(@ModelAttribute("loginForm") LoginForm loginForm, BindingResult result, 
    		@RequestParam("profilePic") MultipartFile file,
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
    		
    		userDTOJDBC = new UserDTO(loginForm.getUsername(), loginForm.getPassword(), loginForm.getFirstName(), loginForm.getLastName(), loginForm.getEmailId(), 
    				      Long.parseLong(loginForm.getContact()), loginForm.getCompany(), loginForm.getProfession(), loginForm.getEducation(), file.getBytes());
    		
	    	addUserStatus = userService.addUser(userDTOJDBC);
	    	
	    	if(addUserStatus)
	    	{
	    		model1 = new ModelAndView("login");
	    		model1.addObject("signupStatus", "Hello "+loginForm.getFirstName()+" "+loginForm.getLastName()+"! Your profile has been created successfully. An email has been sent to "+loginForm.getEmailId()+ " for your confirmation. You can now use your login credentials.");
	    	}
	    	else 
	    	{
	    		model1 = new ModelAndView("register");
	    		model1.addObject("registerStatus", "An error occured while trying to create your profile. Please try again.");
	    	}
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to add a user."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView update(@ModelAttribute("loginForm") LoginForm loginForm, BindingResult result, 
    		@RequestParam("profilePic") MultipartFile file,
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
    		
    		userDTOJDBC = new UserDTO(loginForm.getUserId(), loginForm.getFirstName(), loginForm.getLastName(), loginForm.getEmailId(), 
    				      Long.parseLong(loginForm.getContact()), loginForm.getCompany(), loginForm.getProfession(), loginForm.getEducation(), file.getBytes());
    		
    		updateUserStatus = userService.updateUser(userDTOJDBC, file.getSize());
	    	
    		if(updateUserStatus)
	    	{
	    		model1 = new ModelAndView("editProfile");
	    		model1.addObject("updateStatus", "Hello <strong>"+loginForm.getFirstName()+" "+loginForm.getLastName()+"</strong>! Your profile has been updated successfully. An email has been sent to "+loginForm.getEmailId()+ " for your confirmation.");
	    		userDTO = userService.getProfileInformation(loginForm.getUserId());
	    		model1.addObject("fname", userDTO.getFname());
	    		model1.addObject("lname", userDTO.getLname());
	    		model1.addObject("emailId", userDTO.getEmailId());
	    		model1.addObject("contact", userDTO.getContact());
	    		model1.addObject("professionName", userDTO.getProfessionName());
	    		model1.addObject("companyName", userDTO.getCompanyName());
	    		model1.addObject("educationName", userDTO.getEducationName());
	    		model1.addObject("userId", userDTO.getUserId());
	    		model1.addObject("imageFlag", userDTO.getImageFlag());
	    	}
	    	else 
	    	{
	    		model1 = new ModelAndView("editProfile");
	    		model1.addObject("updateStatus", "An error occured while trying to update your profile. Please try again.");
	    	}
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to update a profile."+e.getMessage());
    	}
		return model1;
    }
}