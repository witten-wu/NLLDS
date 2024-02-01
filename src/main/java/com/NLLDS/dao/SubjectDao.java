package com.NLLDS.dao;

import java.util.List;

import com.NLLDS.model.Subject;

public interface SubjectDao {
    
	List<Subject> selectSubjectByProjectId(String pid);

}