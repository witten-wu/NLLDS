package com.NLLDS.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.NLLDS.dao.UserDao;
import com.NLLDS.model.User;
import com.NLLDS.service.CommonService;


@Service("CommonServiceImpl")
public class CommonServiceImpl implements CommonService{
	
	@Resource
	private UserDao userDao;

	public User selectUserByUidAndPassword(String username, String password) {
		return userDao.selectUserByUidAndPassword(username, password);
	}
}
