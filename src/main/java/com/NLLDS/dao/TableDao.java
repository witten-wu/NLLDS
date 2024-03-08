package com.NLLDS.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.NLLDS.model.Table;

public interface TableDao {
    
    List<Table> selectAllFields();
    
    int createTable(Table table);
    
    List<Table> selectTaskFields(int taskid);
    
    int insertFields(Table table);
    
    int addColumn(Table table);
    
    List<Table> checkTable(@Param("fieldname")String fieldname,@Param("taskid")int taskid);
    
    int insertFieldValue(@Param("tablename") String tablename, @Param("formData") Map<String, String> formData);
    
    int deleteFields(Table table);
    
    int deleteColumn(Table table);
}