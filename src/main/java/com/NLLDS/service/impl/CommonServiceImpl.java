package com.NLLDS.service.impl;

import java.util.List;
import java.util.Map;

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
	
	public List<Project> selectUserProject(String username) {
		return projectDao.selectUserProject(username);
	}
	
	public List<Project> selectProjectQus() {
		return projectDao.selectProjectQus();
	}
	
	public List<Project> selectUserProjectQus(String username) {
		return projectDao.selectUserProjectQus(username);
	}
	
	public List<Project> selectProjectID() {
		return projectDao.selectProjectID();
	}
	
	public List<Project> selectUserProjectID(String username) {
		return projectDao.selectUserProjectID(username);
	}
	
	public List<User> selectAllUser() {
		return userDao.selectAllUser();
	}
	
	public List<User> selectAllCollaborator() {
		return userDao.selectAllCollaborator();
	}
	
	public List<Project> selectQuestionnaire(String pid) {
		return projectDao.selectQuestionnaire(pid);
	}
	
	public List<Project> checkQuestionnaire(String pid) {
		return projectDao.checkQuestionnaire(pid);
	}
	
	public int insertProject(Project project) {
		return projectDao.insertProject(project);
	}
	
	public int updateProject(Project project) {
		return projectDao.updateProject(project);
	}
	
	public List<Project> checkProject(String pname) {
		return projectDao.checkProject(pname);
	}
	
	public List<Subject> selectSubjectByProjectId(String pid) {
		return subjectDao.selectSubjectByProjectId(pid);
	}
	
	public List<Subject> selectSubjectByCollaborator(String pid, String username) {
		return subjectDao.selectSubjectByCollaborator(pid,username);
	}
	
	public List<Subject> selectSubjectTasks(String subjectid) {
		return subjectDao.selectSubjectTasks(subjectid);
	}
	
	public List<Project> selectSubjectQus(String projectid) {
		return projectDao.selectSubjectQus(projectid);
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
	
	public List<Task> selectUserProjectTask(String username) {
		return taskDao.selectUserProjectTask(username);
	}
	
	public int insertTask(Task task) {
		return taskDao.insertTask(task);
	}
	public List<Task> checkTask(String tname, String pid) {
		return taskDao.checkTask(tname, pid);
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
	
	public int insertFieldValue(String tablename, Map<String, String> formData) {
		return tableDao.insertFieldValue(tablename, formData);
	}
	
	public int addColumn(Table table) {
		return tableDao.addColumn(table);
	}
	
	public int updateSubjecttasks(Subject subject) {
		return subjectDao.updateSubjecttasks(subject);
	}
	
	public List<Table> checkTable(String fieldname, int taskid) {
		return tableDao.checkTable(fieldname, taskid);
	}
	
	public int deleteFields(Table table) {
		return tableDao.deleteFields(table);
	}
	
	public int deleteTasks(Task task) {
		return taskDao.deleteTasks(task);
	}
	
	public int deleteProject(Project project) {
		return projectDao.deleteProject(project);
	}
	
	public int deleteColumn(Table table) {
		return tableDao.deleteColumn(table);
	}
}
