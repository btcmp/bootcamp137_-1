package com.xsis.mp1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping
	public String index(Model model) {
		List<Employee> employees = employeeService.selectAll();
		model.addAttribute("employees", employees);
		return "employee";
	}

	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Employee employee) {
		employeeService.save(employee);
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.OK)
	public void delete(@PathVariable long id) {
		Employee employee = new Employee();
		employee.setId(id);
		employee.setFirstName("0");
		employee.setLastName("0");
		employee.setHaveAccount(false);
		employee.setActive(false);
		employeeService.delete(employee);
	}
}
