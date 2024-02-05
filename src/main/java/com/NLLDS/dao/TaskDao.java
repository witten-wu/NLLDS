package com.NLLDS.dao;

import java.util.List;

import com.NLLDS.model.Task;

public interface TaskDao {
    
    List<Task> selectAllTask();
    
    int insertTask(Task task);
    
    List<Task> checkTask(String tname);

}