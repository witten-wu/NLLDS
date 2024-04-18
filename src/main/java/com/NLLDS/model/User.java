package com.NLLDS.model;

public class User {
    private String username;

    private String password;
    
    private int grade;
    
    private String region;

    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public int getGrade() {
    	return grade;
    }
    
    public void setGrade(int grade) {
    	this.grade = grade;
    }
    
    public String getRegion() {
        return region;
    }
    
    public void setRegion(String region) {
        this.region = region;
    }
}