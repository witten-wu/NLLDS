package com.NLLDS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.NLLDS.model.Table;

public interface TableDao {
    
    List<Table> selectAllFields();
    
    int createTable(Table table);
    
    List<Table> selectTaskFields(int taskid);
    
    int insertFields(Table table);
    
    int addColumn(Table table);
    
    List<Table> checkTable(@Param("fieldname")String fieldname,@Param("taskid")int taskid);
}