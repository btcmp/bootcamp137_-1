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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.xsis.mp1.model.Employee;
import com.xsis.mp1.model.EmployeeOutlet;
import com.xsis.mp1.model.Outlet;
import com.xsis.mp1.model.PurchaseRequest;
import com.xsis.mp1.model.Role;
import com.xsis.mp1.service.EmployeeService;
import com.xsis.mp1.service.OutletService;
import com.xsis.mp1.service.RoleService;

@Controller
@RequestMapping("/mst/employee")
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@Autowired
	OutletService outletService;
	
	
	@Autowired
	RoleService roleService;
	
	@RequestMapping
	public String index(Model model) {
		List<Employee> employees = employeeService.getListByStatus();
		List<Outlet> outlets = outletService.selectAll();
		List<Role> roles = roleService.selectAll();
		model.addAttribute("employees", employees);
		model.addAttribute("outlets", outlets);
		model.addAttribute("roles", roles);
		return "employee";
	}

	@RequestMapping(value="/save", method=RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public void save(@RequestBody Employee employee) {
		employeeService.saveOrUpdate(employee);
	}
	
	@RequestMapping(value = "/get-one/{id}")
	@ResponseBody
	public Employee getOne(@PathVariable long id) {
		return employeeService.getOne(id);
	}
	
	@RequestMapping(value="/get-all", method=RequestMethod.GET)
	@ResponseBody
	public List<Employee> getAll(){
		return employeeService.selectAll(); 
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
	
	@RequestMapping(value="/update-status", method=RequestMethod.PUT)
	@ResponseStatus(HttpStatus.OK)
	public void updateStatus(@RequestBody Employee employee) {
		employeeService.updateStatus(employee); 
	}
	
	@RequestMapping(value="/profile/{id}", method = RequestMethod.GET)
	public String cari(@PathVariable long id, Model model) {
		System.out.println("id emp =" + id);
		Employee emp = employeeService.getOne(id);
		model.addAttribute("emp", emp);
		return "profile";
	}
	
	@RequestMapping("/check-email")
	@ResponseBody
	public int getEmail(@RequestParam(value="email", defaultValue="") String email) {
		System.out.println("masuk email");
		return employeeService.countEmail(email);
	}
	
	@RequestMapping("/check-user")
	@ResponseBody
	public int getUser(@RequestParam(value="user", defaultValue="") String user) {
		System.out.println("masuk");
		return employeeService.countUser(user);
	}
}
