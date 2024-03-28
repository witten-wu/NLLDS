package com.NLLDS.model;
import java.sql.Timestamp;

public class Task {
    private int tid;
    
    private String pid;

    private String tname;

    private String createby;

    private Timestamp createdate;

    private String description;
    
    private String fields_table;

    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }
    
    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getCreateby() {
        return createby;
    }

    public void setCreateby(String createby) {
        this.createby = createby;
    }

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getFields_table() {
        return fields_table;
    }

    public void setFields_table(String fields_table) {
        this.fields_table = fields_table;
    }

   
}