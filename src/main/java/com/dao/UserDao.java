package com.dao;

import com.domain.User;

public interface UserDao extends SqlDao{

    User findByUserName(String userName);
}