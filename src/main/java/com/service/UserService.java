package com.service;

import java.util.List;
import java.util.Map;
import com.domain.User;

public interface UserService {

	public User selectOne(Long id);
	
	public int save(User user);
	
	public int update(User user);
	
	public int deleteByPrimaryKey(Long id);
	
	public User findByUserName(String userName);
}
