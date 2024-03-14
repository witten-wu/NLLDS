package com.NLLDS.service;

import java.util.List;
import java.util.Map;

import com.NLLDS.model.Project;
import com.NLLDS.model.Subject;
import com.NLLDS.model.User;
import com.NLLDS.model.Task;
import com.NLLDS.model.Table;

public interface CommonService {
	
	User selectUserByUidAndPassword(String username,String password);
	
	List<Project> selectAllProject();
	
	List<Project> selectUserProject(String username);
	
	List<Project> selectProjectQus();
	
	List<Project> selectUserProjectQus(String username);
	
	List<Project> selectProjectID();
	
	List<Project> selectUserProjectID(String username);
	
	List<User> selectAllUser();
	
	List<Project> selectQuestionnaire(String pid);
	
	List<Project> checkQuestionnaire(String pid);
	
	int insertProject(Project project);
	
	int updateProject(Project project);
	
	List<Project> checkProject(String pname);
	
	List<Subject> selectSubjectByProjectId(String pid);
	
	List<Subject> selectSubjectTasks(String subjectid);
	
	List<Project> selectSubjectQus(String projectid);
	
	int insertSubject(Subject subject);
	
	List<Subject> checkSubject(String subjectno);
	
	List<Task> selectAllTask();
	
	int insertTask(Task task);
	
	List<Task> checkTask(String tname);
	
	int createTable(Table table);
	
	List<Table> selectTaskFields(int taskid);
	
	int insertFields(Table table);
	
	int insertFieldValue(String tablename, Map<String, String> formData);
	
	int addColumn(Table table);
	
	int updateSubjecttasks(Subject subject);
	
	List<Table> checkTable(String fieldname, int taskid);
	
	int deleteFields(Table table);
	
	int deleteColumn(Table table);
}
