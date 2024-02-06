package com.NLLDS.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.NLLDS.dao.ProjectDao;
import com.NLLDS.dao.SubjectDao;
import com.NLLDS.dao.UserDao;
import com.NLLDS.dao.TaskDao;
import com.NLLDS.dao.TableDao;
import com.NLLDS.model.User;
import com.NLLDS.model.Project;
import com.NLLDS.model.Subject;
import com.NLLDS.model.Task;
import com.NLLDS.model.Table;
import com.NLLDS.service.CommonService;


@Service("CommonServiceImpl")
public class CommonServiceImpl implements CommonService{
	
	@Resource
	private UserDao userDao;
	
	@Resource
	private ProjectDao projectDao;
	
	@Resource
	private SubjectDao subjectDao;
	
	@Resource
	private TaskDao taskDao;
	
	@Resource
	private TableDao tableDao;

	public User selectUserByUidAndPassword(String username, String password) {
		return userDao.selectUserByUidAndPassword(username, password);
	}
	
	public List<Project> selectAllProject() {
		return projectDao.selectAllProject();
	}
	
	public int insertProject(Project project) {
		return projectDao.insertProject(project);
	}
	public List<Project> checkProject(String pname) {
		return projectDao.checkProject(pname);
	}
	
	public List<Subject> selectSubjectByProjectId(String pid) {
		return subjectDao.selectSubjectByProjectId(pid);
	}
	
	public int insertSubject(Subject subject) {
		return subjectDao.insertSubject(subject);
	}
	public List<Subject> checkSubject(String subjectno) {
		return subjectDao.checkSubject(subjectno);
	}
	
	public List<Task> selectAllTask() {
		return taskDao.selectAllTask();
	}
	
	public int insertTask(Task task) {
		return taskDao.insertTask(task);
	}
	public List<Task> checkTask(String tname) {
		return taskDao.checkTask(tname);
	}
	
	public int createTable(Table table) {
		return tableDao.createTable(table);
	}
	
	public List<Table> selectTaskFields(int taskid) {
		return tableDao.selectTaskFields(taskid);
	}
	
	public int insertFields(Table table) {
		return tableDao.insertFields(table);
	}
	
	public int addColumn(Table table) {
		return tableDao.addColumn(table);
	}
	
	public List<Table> checkTable(String fieldname, int taskid) {
		return tableDao.checkTable(fieldname, taskid);
	}
	
}
