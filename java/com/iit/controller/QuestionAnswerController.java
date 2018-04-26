package com.iit.controller;

import java.util.ArrayList;
import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.iit.domain.TopQuestions;
import com.iit.domain.UserDTO;
import com.iit.services.UserService;

@Controller
public class QuestionAnswerController {
	
	@Autowired
	private UserService userService;
	
	private boolean addAnswerStatus = true;
	private boolean addQuestionStatus = true;
	private int answerCount;
	UserDTO userDTO = null;
	
	final static Logger logger = Logger.getLogger(QuestionAnswerController.class);
	
	UserDTO userDTOJDBC = new UserDTO();
    
    @RequestMapping("/saveQuestion")
    public ModelAndView saveQuestion(@ModelAttribute("topQuestions") TopQuestions topQuestions, BindingResult result, 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
    		
    		addQuestionStatus = userService.saveQuestion(topQuestions);
	    	
	    	if(addQuestionStatus)
	    	{
	    		model1 = new ModelAndView("welcomePage");
	    		model1.addObject("saveQuestionSuccessStatus", "Your question has been posted successfully.");
	    	}
	    	else 
	    	{
	    		model1 = new ModelAndView("welcomePage");
	    		model1.addObject("saveQuestionErrorStatus", "An error occured while trying to post a new question. Please try again.");
	    	}
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to add a question."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/displayAnswers")
    public ModelAndView displayAnswers(HttpServletRequest request, HttpServletResponse response, @RequestParam("question") String question)
    {
    	ModelAndView model1 = null;
    	String json = "[]";
    	int numberOfViews = 0;
    	try
    	{
    			answerCount = 0;
	    		model1 = new ModelAndView("displayQuestionsAnswers");
	    		List<TopQuestions> list = null;
	    		list = userService.getAnswers(question);
	    		numberOfViews = userService.getNumberOfViewsQuestion(question);
	    		answerCount = list.size();
	        	if(answerCount!=0)
	        		json = getJsonString(list);
	        	StringBuffer sb = new StringBuffer("{\"items\":");
				sb.append(json);
				sb.append("}");		
				json =  sb.toString();
				model1.addObject("json", json);
				model1.addObject("question", question);
				model1.addObject("answerCount", answerCount);
				model1.addObject("numberOfViews", numberOfViews);
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the answers."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/saveAnswer", method = RequestMethod.POST)
    public ModelAndView saveAnswer(@ModelAttribute("answerForm") TopQuestions topQuestions, BindingResult result, HttpServletRequest request, HttpServletResponse response)
    {
    	int numberOfViews = 0;
    	ModelAndView model1 = null;
    	String json = "[]";
    	try
    	{
    			//to save the answer
    		    addAnswerStatus = userService.saveAnswer(topQuestions);
    		    
    		    //to display the answers
    			answerCount = 0;
	    		model1 = new ModelAndView("displayQuestionsAnswers");
	    		List<TopQuestions> list = null;
	    		list = userService.getAnswers(topQuestions.getQuestion_name());
	    		numberOfViews = userService.getNumberOfViewsQuestion(topQuestions.getQuestion_name());
	    		answerCount = list.size();
	        	if(answerCount!=0)
	        		json = getJsonString(list);
	        	StringBuffer sb = new StringBuffer("{\"items\":");
				sb.append(json);
				sb.append("}");		
				json =  sb.toString();
				model1.addObject("json", json);
				model1.addObject("question", topQuestions.getQuestion_name());
				model1.addObject("answerCount", answerCount);
				model1.addObject("numberOfViews", numberOfViews);
				
    		    if(addAnswerStatus)
	    		    
					model1.addObject("answerSuccessStatus", "Your answer was successfully posted.");
    		    else
    		    	model1.addObject("answerErrorStatus", "Your answer was not posted. Please try again.");
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the answers."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/displayAnswerPage")
    public ModelAndView displayAnswersPage(HttpServletRequest request, HttpServletResponse response)
    {
    	ModelAndView model1 = null;
    	try
    	{
	    		model1 = new ModelAndView("displayAnswers");
	    		HttpSession httpSession = request.getSession(false);
	    		model1.addObject("fbUserId", httpSession.getAttribute("fbUserId"));
    	}
    	catch(Exception e)	
    	{
    		System.out.println("An error occured while trying to display the answers page."+e.getMessage());
    	}
		return model1;
    }
    
    @RequestMapping(value="/displayAnswerPageForUsers")
    public ModelAndView displayAnswersPageForUsers(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam("userId") int userId)
    {
    	ModelAndView model1 = null;
    	try
    	{
	    		model1 = new ModelAndView("displayAnswersForUsers");
	    		model1.addObject("userId", userId);
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to display the answers page for other users."+e.getMessage());
    	}
		return model1;
    }
    
    @ResponseBody
    @RequestMapping(value = "/topQuestions", method = RequestMethod.POST)
    public String displayTopQuestions( 
    		HttpServletRequest request, HttpServletResponse response)
    {
    	String json = "[]";
    	List<TopQuestions> list = new ArrayList<TopQuestions>();
    	try
    	{
    		list = userService.getTopQuestions();
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
    
    @ResponseBody
    @RequestMapping(value = "/userQuestions", method = RequestMethod.POST)
    public String displayUserAskedQuestions( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	String json = "[]";
    	List<TopQuestions> list = new ArrayList<TopQuestions>();
    	try
    	{
    		list = userService.getUserAskedQuestions(userId);
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
    
    @ResponseBody
    @RequestMapping(value = "/userAnswers", method = RequestMethod.POST)
    public String displayUsersAnswers( 
    		HttpServletRequest request, HttpServletResponse response, @RequestParam("userId") int userId)
    {
    	String json = "[]";
    	List<TopQuestions> list = new ArrayList<TopQuestions>();
    	try
    	{
    		list = userService.getUsersAnswers(userId);
        	if(list!=null)
        		json = getJsonString(list);
        	StringBuffer sb = new StringBuffer("{\"items\":");
			sb.append(json);
			sb.append("}");		
			json =  sb.toString();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying get the answersr that user has answered. "+e.getStackTrace());
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