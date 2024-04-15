package com.NLLDS.model;
import java.sql.Timestamp;

public class Project {
    private String pid;

    private String pname;

    private String createby;

    private String manageby;
    
    private String collaborator;

    private Timestamp createdate;

    private String description;
    
    private String questionnaire;
    
    private String qustable;

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
    
    public String getCollaborator() {
        return collaborator;
    }

    public void setCollaborator(String collaborator) {
        this.collaborator = collaborator;
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
    
    public String getQuestionnaire() {
        return questionnaire;
    }

    public void setQuestionnaire(String questionnaire) {
        this.questionnaire = questionnaire;
    }

    public String getQustable() {
        return qustable;
    }

    public void setQustable(String qustable) {
        this.qustable = qustable;
    }
}