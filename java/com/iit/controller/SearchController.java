package com.iit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.iit.domain.Search;
import com.iit.domain.TopQuestions;
import com.iit.domain.UserDTO;
import com.iit.services.UserService;

@Controller
public class SearchController {
	
	@Autowired
	private UserService userService;
	
	UserDTO userDTO = null;
	
	final static Logger logger = Logger.getLogger(SearchController.class);
	
	UserDTO userDTOJDBC = new UserDTO();
    
	@RequestMapping(value = "/getAutoSuggest", method = RequestMethod.GET, headers="Accept=*/*")
	public @ResponseBody List<String> getCountryList(@RequestParam("term") String query) {
		
		List<String> countryList = userService.getAutoSuggestData(query);
		return countryList;
	}
	
	@RequestMapping(value="/search")
    public ModelAndView displaySearchPage(HttpServletRequest request, HttpServletResponse response, @RequestParam("searchData") String searchData)
    {
    	ModelAndView model1 = null;
    	try
    	{
	    		model1 = new ModelAndView("displaySearchResults");
	    		model1.addObject("searchData", searchData);
    	}
    	catch(Exception e)
    	{
    		System.out.println("An error occured while trying to get the display search page."+e.getMessage());
    	}
		return model1;
    }
	 @ResponseBody
	    @RequestMapping(value = "/findSearchResults", method = RequestMethod.POST)
	    public String findSearchResults( 
	    		HttpServletRequest request, HttpServletResponse response, @RequestParam("searchData") String searchData)
	    {
		 String json = "";
		 String searchType = "";
		 int userId = 0;
		 List<Search> list = new ArrayList<Search>();
	    	try
	    	{
	    		searchType = userService.findSearchResults(searchData);
	    		Search search = new Search();
	    		if(!searchType.equals("profile"))
	    		{
		    		search.setSearchData(searchData);
		    		search.setSearchType(searchType);
		    		list.add(search);
	    		}
	    		else
	    		{
	    			 String temp = searchData.split("Profile:")[1].trim();
	    			    String fname = temp.split(" ")[0].trim();
	    			    String lname = temp.split(" ")[1].trim();
	    			userId = userService.getUserId(fname, lname);
	    			search.setSearchData(searchData);
		    		search.setSearchType(searchType);
	    			search.setUserId(userId);
	    			list.add(search);
	    		}
	    		json = getJsonString(list);
	        	StringBuffer sb = new StringBuffer("{\"items\":");
				sb.append(json);
				sb.append("}");		
				json =  sb.toString();
	    	}
	    	catch(Exception e)
	    	{
	    		System.out.println("An exception occured while trying to find the search type"+e.getStackTrace());
	    	}
			return json;
	    }
	    
	    @RequestMapping(value = "/displayAnswerResult")
	    public ModelAndView displayAnswerResults( 
	    		HttpServletRequest request, HttpServletResponse response, @RequestParam("answer") String answer)
	    {
			TopQuestions topQuestions = null;
			ModelAndView model = null;
	    	try
	    	{
	    		    topQuestions = userService.getSearchAnswer(answer);
	    			model = new ModelAndView("displaySearchAnswer");
	    			model.addObject("question", topQuestions.getQuestion_name());
	    			model.addObject("answer", topQuestions.getAnswer_name());
	    			model.addObject("fname", topQuestions.getFirst_name());
	        		model.addObject("lname", topQuestions.getLast_name());
	        		model.addObject("emailId", topQuestions.getEmailId());
	        		model.addObject("contact", topQuestions.getContact());
	        		model.addObject("professionName", topQuestions.getProfession());
	        		model.addObject("companyName", topQuestions.getCompany_name());
	        		model.addObject("educationName", topQuestions.getEducation());
	        		model.addObject("userId", topQuestions.getUserId());
	        		model.addObject("imageFlag", topQuestions.getImageFlag());
	    	}
	    	catch(Exception e)
	    	{
	    		System.out.println("An exception occured while trying to display the search answer. "+e.getStackTrace());
	    	}
			return model;
	    }
	 
	 private String getJsonString(@SuppressWarnings("rawtypes") List list) {
	    	Gson gson = new Gson();
			String json;
			json = gson.toJson(list);
			return json;
		}
}