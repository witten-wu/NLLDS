package com.NLLDS.service;

import com.NLLDS.model.User;

public interface CommonService {
	
	User selectUserByUidAndPassword(String username,String password);
}
