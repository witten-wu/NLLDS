package com.NLLDS.service;

import java.util.List;

import com.NLLDS.model.Project;
import com.NLLDS.model.Subject;
import com.NLLDS.model.User;

public interface CommonService {
	
	User selectUserByUidAndPassword(String username,String password);
	
	List<Project> selectAllProject();
	
	List<Subject> selectSubjectByProjectId(String pid);
	
}
