package com.NLLDS.service;

import java.util.List;

import com.NLLDS.model.Project;
import com.NLLDS.model.Subject;
import com.NLLDS.model.User;
import com.NLLDS.model.Task;
import com.NLLDS.model.Table;

public interface CommonService {
	
	User selectUserByUidAndPassword(String username,String password);
	
	List<Project> selectAllProject();
	
	int insertProject(Project project);
	
	List<Project> checkProject(String pname);
	
	List<Subject> selectSubjectByProjectId(String pid);
	
	int insertSubject(Subject subject);
	
	List<Subject> checkSubject(String subjectno);
	
	List<Task> selectAllTask();
	
	int insertTask(Task task);
	
	List<Task> checkTask(String tname);
	
	int createTable(Table table);
	
	List<Table> selectTaskFields(int taskid);
	
	int insertFields(Table table);
	
	int addColumn(Table table);
	
	List<Table> checkTable(String fieldname, int taskid);
}
