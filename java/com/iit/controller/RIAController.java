package com.iit.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.iit.domain.User;
import com.iit.domain.UserDTO;

@Controller
public class RIAController {
	
	final static Logger logger = Logger.getLogger(RIAController.class);
	
	UserDTO userDTOJDBC = new UserDTO();
    
    @RequestMapping(value = "/calculator", method = RequestMethod.GET)
    public String calculatorFunctions(ModelMap map)
    {
        return "apannu_lab1";
    }
    
    @RequestMapping(value = "/app", method = RequestMethod.GET)
    public String app(ModelMap map)
    {
        return "app";
    }
    
    @RequestMapping(value = "/app1", method = RequestMethod.GET)
    public String app1(ModelMap map)
    {
        return "app1";
    }
    
    //ajax call
    @RequestMapping(value = "/ajaxCall", method = RequestMethod.GET)
    public String displayTable(ModelMap map)
    {
        return "apannu_lab3";
    }
    
    @RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index() {

		User userForm = new User();

		return new ModelAndView("user", "userForm", userForm);
	}
	
	 @RequestMapping(value = "/lab4", method = RequestMethod.GET)
	    public String lab4(ModelMap map)
	    {
	        return "yganorkar_lab4";
	    }
	 
	 @RequestMapping(value = "/editor", method = RequestMethod.GET)
	    public String editor(ModelMap map)
	    {
	        return "multipleEditors";
	    }
}