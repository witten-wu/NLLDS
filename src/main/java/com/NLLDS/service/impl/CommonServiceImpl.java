package com.NLLDS.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.NLLDS.dao.ProjectDao;
import com.NLLDS.dao.SubjectDao;
import com.NLLDS.dao.UserDao;
import com.NLLDS.model.User;
import com.NLLDS.model.Project;
import com.NLLDS.model.Subject;
import com.NLLDS.service.CommonService;


@Service("CommonServiceImpl")
public class CommonServiceImpl implements CommonService{
	
	@Resource
	private UserDao userDao;
	
	@Resource
	private ProjectDao projectDao;
	
	@Resource
	private SubjectDao subjectDao;

	public User selectUserByUidAndPassword(String username, String password) {
		return userDao.selectUserByUidAndPassword(username, password);
	}
	
	public List<Project> selectAllProject() {
		return projectDao.selectAllProject();
	}
	
	public List<Subject> selectSubjectByProjectId(String pid) {
		return subjectDao.selectSubjectByProjectId(pid);
	}
}
