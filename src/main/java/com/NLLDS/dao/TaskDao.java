package com.NLLDS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.NLLDS.model.Task;

public interface TaskDao {
    
    List<Task> selectAllTask();
    
    List<Task> selectUserProjectTask(String username);
    
    int insertTask(Task task);
    
    List<Task> checkTask(@Param("tname")String tname,@Param("pid")String pid);
    
    int deleteTasks(Task task);
}