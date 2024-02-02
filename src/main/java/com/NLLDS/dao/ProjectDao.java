package com.NLLDS.dao;

import java.util.List;

import com.NLLDS.model.Project;

public interface ProjectDao {
    
    List<Project> selectAllProject();
    
    int insertProject(Project project);
    
    List<Project> checkProject(String pname);

}