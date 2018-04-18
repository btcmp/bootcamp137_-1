package com.xsis.mp1.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.xsis.mp1.model.Employee;

@Controller
@RequestMapping(value = "/")
public class HomeController {

	@Autowired
	HttpSession httpSession;
	
	@RequestMapping
	public String home(Model model) {
		Employee emp = (Employee) httpSession.getAttribute("employee");
		System.out.println(emp);
		if (emp != null) {
			return "main";
		} else {
			return "login";
		}
	}
}
