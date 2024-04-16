package com.NLLDS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.NLLDS.model.Subject;

public interface SubjectDao {
    
	List<Subject> selectSubjectByProjectId(String pid);
	
	List<Subject> selectSubjectByCollaborator(@Param("pid")String pid, @Param("username")String username);
	
	int insertSubject(Subject subject);
	    
	List<Subject> checkSubject(String subjectno);
	
	List<Subject> selectSubjectTasks(String subjectid);
	
	int updateSubjecttasks(Subject subject);

}