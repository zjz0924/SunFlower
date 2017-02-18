package com.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.dao.UserDao;
import com.domain.User;
import com.service.UserService;

@Service
@Transactional
public class UserServiceImpl implements UserService{

	private static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	private UserDao userDao;
	
	public User selectOne(Long id) {
		return userDao.selectOne(id);
	}

	public int save(User user) {
		return userDao.insert(user);
	}

	public int update(User user) {
		return userDao.update(user);
	}

	public int deleteByPrimaryKey(Long id) {
		return userDao.deleteByPrimaryKey(id);
	}

	public User findByUserName(String userName) {
		return userDao.findByUserName(userName);
	}
}





