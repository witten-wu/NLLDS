package com.NLLDS.model;

public class Table {
	private int id;
	
	private String tablename;
	
	private String fieldname;
	
	private String remark;
	
	private int taskid;
	
	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
	
	public String getTablename() {
        return tablename;
    }

    public void setdTablename(String tablename) {
        this.tablename = tablename;
    }
	
	public String getFieldname() {
        return fieldname;
    }

    public void setFieldname(String fieldname) {
        this.fieldname = fieldname;
    }
    
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    public int getTaskid() {
        return taskid;
    }

    public void setTaskid(int taskid) {
        this.taskid = taskid;
    }
}