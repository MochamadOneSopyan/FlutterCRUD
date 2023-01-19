package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.User;
import com.example.demo.service.IUserService;

@RestController
@CrossOrigin(origins = "http://localhost:8080")
@RequestMapping("/api/user")
public class UserContoller {
	public IUserService getUserService() {
		return userService;
	}

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

	@Autowired
	IUserService userService;
	
	
	@PostMapping("/insert")
	public User insertUser(@RequestBody User user){
		return userService.insertUser(user);
	}
	
	@GetMapping("/getAll")
	public List<User> getAllUser(){
		return userService.getAllUser();
	}
	
	@PutMapping("/update/{id}")
	public User updateUser(@PathVariable int id, @RequestBody User user) {
		return userService.updateUser(id, user);
	}
	
	@DeleteMapping("/delete/{id}")
	public User deleteUser(@PathVariable int id) {
		return userService.deleteUser(id);
	}
	
	@GetMapping("/updateGetId/{id}")
	public User updateGetId(@PathVariable int id){
		return userService.updateGetId(id);
	}

}
