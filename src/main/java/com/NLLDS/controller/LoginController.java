package com.NLLDS.controller;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.NLLDS.model.User;
import com.NLLDS.util.CommonUtil;
import com.NLLDS.util.EnumUtil;
import com.NLLDS.model.Project;
import com.NLLDS.model.Subject;
import com.NLLDS.model.Task;
import com.NLLDS.model.Table;
import com.NLLDS.service.CommonService;
import com.alibaba.fastjson.JSONObject;

@Controller
public class LoginController {
	
	@Autowired
	CommonService commonService;    
    
    @RequestMapping("/login")
    public String login() {
        return "login";
    }
    
    @RequestMapping("/projectlist")
    public String projectlist() {
        return "projectlist";
    }
    
    @RequestMapping("/subjectlist")
    public String subjectlist() {
        return "subjectlist";
    }
    
    @RequestMapping("/tasklist")
    public String tasklist() {
        return "tasklist";
    }
    
    @RequestMapping("/taskfields")
    public String taskfields() {
        return "taskfields";
    }
    
    @RequestMapping("/loginclick")
    @ResponseBody
    public JSONObject loginclick(HttpSession session,String username,String password){
		try{
			User user=commonService.selectUserByUidAndPassword(username, password);
			if(user==null){
				return CommonUtil.constructResponse(EnumUtil.PASSWORD_ERROR, "Username/Password Error", null);
			}else{
				session.setAttribute("user", user);	
				return CommonUtil.constructResponse(EnumUtil.OK, "Success", user);
			}
		}catch(Exception e){
			return CommonUtil.constructExceptionJSON(EnumUtil.UNKOWN_ERROR, "UNKOWN_ERROR", null);
		}
	}
    
    @RequestMapping("/showProjectList")
    @ResponseBody
    public JSONObject showProjectList(HttpSession session) throws Exception {
		List<Project> projects=commonService.selectAllProject();
		if(projects.isEmpty()||projects.size()==0){
			return CommonUtil.constructResponse(0,"no record", null);
		}else{
			return CommonUtil.constructResponse(EnumUtil.OK,"project info", projects);
		}
	}
    
    @RequestMapping("/showSubjectList")
    @ResponseBody
    public JSONObject showSubjectList(String pid) throws Exception {
		List<Subject> subjects=commonService.selectSubjectByProjectId(pid);
		if(subjects.isEmpty()||subjects.size()==0){
			return CommonUtil.constructResponse(0,"no record", null);
		}else{
			return CommonUtil.constructResponse(EnumUtil.OK,"subject info", subjects);
		}
	}
    
    @RequestMapping("/showTaskList")
    @ResponseBody
    public JSONObject showTaskList() throws Exception {
		List<Task> tasks=commonService.selectAllTask();
		if(tasks.isEmpty()||tasks.size()==0){
			return CommonUtil.constructResponse(0,"no record", null);
		}else{
			return CommonUtil.constructResponse(EnumUtil.OK,"subject info", tasks);
		}
	}
    
    @RequestMapping("/addProject")
	@ResponseBody
	public JSONObject addProject(String pname,String createdby,String manageby,String description) throws Exception {
    	Project project=new Project();
    	project.setPname(pname);
    	project.setCreateby(createdby);
    	project.setManageby(manageby);
    	project.setDescription(description);
    	
    	List<Project> projects=commonService.checkProject(pname);
    	if(projects.isEmpty()){
	    	Integer resultOfInsertProject=commonService.insertProject(project);
			if(resultOfInsertProject>0){
				return CommonUtil.constructResponse(EnumUtil.OK,"insert success", null);
			}else{
				return CommonUtil.constructResponse(0,"insert error", null);
			}
    	}else{
			return CommonUtil.constructResponse(0,"Project name already exists", null);
		}
	}
    
    @RequestMapping("/addSubject")
	@ResponseBody
	public JSONObject addSubject(String subjectno,String projectid) throws Exception {
    	Subject subject=new Subject();
    	subject.setSubjectno(subjectno);
    	subject.setProjectid(projectid);

    	List<Subject> subjects=commonService.checkSubject(subjectno);
    	if(subjects.isEmpty()){
	    	Integer resultOfInsertSubject=commonService.insertSubject(subject);
			if(resultOfInsertSubject>0){
				return CommonUtil.constructResponse(EnumUtil.OK,"insert success", null);
			}else{
				return CommonUtil.constructResponse(0,"insert error", null);
			}
    	}else{
			return CommonUtil.constructResponse(0,"Subject No. already exists", null);
		}
	}
    
    @RequestMapping("/addTask")
	@ResponseBody
	public JSONObject addTask(String tname,String createby,String description, String fields_table) throws Exception {
    	Task task=new Task();
    	task.setTname(tname);
    	task.setCreateby(createby);
    	task.setDescription(description);
    	task.setFields_table(fields_table);
    	List<Task> tasks=commonService.checkTask(tname);
    	if(tasks.isEmpty()){
	    	Integer resultOfInsertTask=commonService.insertTask(task);
			if(resultOfInsertTask>0){
				return CommonUtil.constructResponse(EnumUtil.OK,"insert success", null);
			}else{
				return CommonUtil.constructResponse(0,"insert error", null);
			}
    	}else{
			return CommonUtil.constructResponse(0,"Task name already exists", null);
		}
	}
    
    @RequestMapping("/createTable")
	@ResponseBody
	public JSONObject createTable(String fields_table) throws Exception {
    	Table table=new Table();
    	table.setdTablename(fields_table);
    	Integer resultOfCreateTable=commonService.createTable(table);
		if(resultOfCreateTable>0){
			return CommonUtil.constructResponse(EnumUtil.OK,"create success", null);
		}else{
			return CommonUtil.constructResponse(0,"create error", null);
		}
	}
    
}
