package com.NLLDS.service;

import java.util.List;

import com.NLLDS.model.Project;
import com.NLLDS.model.User;

public interface CommonService {
	
	User selectUserByUidAndPassword(String username,String password);
	
	List<Project> selectAllProject();
	
}
