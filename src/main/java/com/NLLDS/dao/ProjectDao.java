package com.NLLDS.dao;

import java.util.List;

import com.NLLDS.model.Project;

public interface ProjectDao {
    
    List<Project> selectAllProject();
    
    List<Project> selectProjectQus();
    
    List<Project> selectQuestionnaire(String pid);
    
    List<Project> checkQuestionnaire(String pid);
    
    int insertProject(Project project);
    
    int updateProject(Project project);
    
    List<Project> checkProject(String pname);

}