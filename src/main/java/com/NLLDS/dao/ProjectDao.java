package com.NLLDS.dao;

import java.util.List;

import com.NLLDS.model.Project;

public interface ProjectDao {
    
    List<Project> selectAllProject();

}