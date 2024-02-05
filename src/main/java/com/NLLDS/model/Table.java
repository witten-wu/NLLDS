package com.NLLDS.model;

public class Table {
	
	private String tablename;
	
	private String fieldname;
	
	private String datatype;
	
	private String length;
	
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
    
    public String getDatatype() {
        return datatype;
    }

    public void setDatatype(String datatype) {
        this.datatype = datatype;
    }
    
    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }
}