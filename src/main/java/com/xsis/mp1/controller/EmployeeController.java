package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	public String index(Model model) {
		List<Employee> employees = employeeService.selectAll();
		model.addAttribute("employees", employees);
		return "employee";
	}
	
	
}
