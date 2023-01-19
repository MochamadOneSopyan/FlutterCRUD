package com.example.demo.service;

import java.util.List;

import com.example.demo.model.User;

public interface IUserService {
	public User insertUser(User user);
	public List<User> getAllUser();
	public User updateUser(int id, User user);
	public User deleteUser(int id);
	public User updateGetId(int id);

}
