package com.NLLDS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.NLLDS.model.User;

public interface UserDao {
	
    User selectUserByUidAndPassword(@Param("username")String username,@Param("password")String password);
    
    List<User> selectAllUser();
    
    List<User> selectAllCollaborator();
}