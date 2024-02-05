package com.NLLDS.dao;

import java.util.List;

import com.NLLDS.model.Table;

public interface TableDao {
    
    List<Table> selectAllFields();
    
    int createTable(Table table);
}