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
}
