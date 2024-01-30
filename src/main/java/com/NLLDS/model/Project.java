package com.NLLDS.model;
import java.sql.Timestamp;

public class Project {
    private String pid;

    private String pname;

    private String createby;

    private String manageby;

    private Timestamp createdate;

    private String description;

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getCreateby() {
        return createby;
    }

    public void setCreateby(String createby) {
        this.createby = createby;
    }

    public String getManageby() {
        return manageby;
    }

    public void setManageby(String manageby) {
        this.manageby = manageby;
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

   
}