package com.NLLDS.controller;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
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
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;

@Controller
public class LoginController {
	
	@Autowired
	CommonService commonService;    
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
    
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
    
    @RequestMapping("/questionnaire")
    public String questionnaire() {
        return "questionnaire";
    }
    
    @RequestMapping("/tasklist")
    public String tasklist() {
        return "tasklist";
    }
    
    @RequestMapping("/taskfields")
    public String taskfields() {
        return "taskfields";
    }
    
    @RequestMapping("/subjectask")
    public String subjectask() {
        return "subjectask";
    }
    
    @RequestMapping("/subjectquestionnaire")
    public String subjectquestionnaire() {
        return "subjectquestionnaire";
    }
    
    @RequestMapping("/projectquestionnaire")
    public String projectquestionnaire() {
        return "projectquestionnaire";
    }
    
    @RequestMapping("/loginclick")
    @ResponseBody
    public JSONObject loginclick(HttpSession session,String username,String password){
		User user=commonService.selectUserByUidAndPassword(username, password);
		if(user==null){
			return CommonUtil.constructResponse(EnumUtil.PASSWORD_ERROR, "Username/Password Error", null);
		}else{
			session.setAttribute("user", user);	
			return CommonUtil.constructResponse(EnumUtil.OK, "Success", user);
		}
	}
    
    @RequestMapping("/showProjectList")
    @ResponseBody
    public JSONObject showProjectList(String username, int grade) throws Exception {
    	if (grade == 1) {
    		List<Project> projects=commonService.selectAllProject();
    		if(projects.isEmpty()||projects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"project info", projects);
    		}
    	}else {
    		List<Project> projects=commonService.selectUserProject(username);
    		if(projects.isEmpty()||projects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"project info", projects);
    		}
    	}
	}
    
    @RequestMapping("/showProjectQus")
    @ResponseBody
    public JSONObject showProjectQus(String username, int grade) throws Exception {
    	if (grade == 1) {
    		List<Project> projects=commonService.selectProjectQus();
    		if(projects.isEmpty()||projects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"project info", projects);
    		}
    	}else {
    		List<Project> projects=commonService.selectUserProjectQus(username);
    		if(projects.isEmpty()||projects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"project info", projects);
    		}
    	}
		
	}
    
    @RequestMapping("/getQuestionnaire")
    @ResponseBody
    public JSONObject getQuestionnaire(String pid) throws Exception {
		List<Project> projects=commonService.selectQuestionnaire(pid);
		if(projects.isEmpty()||projects.size()==0){
			return CommonUtil.constructResponse(0,"no record", null);
		}else{
			return CommonUtil.constructResponse(EnumUtil.OK,"questionnaire info", projects);
		}
	}
    
    @RequestMapping("/showSubjectList")
    @ResponseBody
    public JSONObject showSubjectList(String pid, int grade, String username) throws Exception {
    	if (grade == 3) {
    		List<Subject> subjects=commonService.selectSubjectByCollaborator(pid,username);
    		if(subjects.isEmpty()||subjects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"subject info", subjects);
    		}
    	}else {
    		List<Subject> subjects=commonService.selectSubjectByProjectId(pid);
    		if(subjects.isEmpty()||subjects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"subject info", subjects);
    		}
    	}
	}
    
    @RequestMapping("/showTaskList")
    @ResponseBody
    public JSONObject showTaskList(String username, int grade) throws Exception {
    	if (grade == 1) {
    		List<Task> tasks=commonService.selectAllTask();
    		if(tasks.isEmpty()||tasks.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"task info", tasks);
    		}
    	}else {
    		List<Task> tasks=commonService.selectUserProjectTask(username);
    		if(tasks.isEmpty()||tasks.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"task info", tasks);
    		}
    	}
	}
    
    @RequestMapping("/showProjectID")
    @ResponseBody
    public JSONObject showProjectID(String username, int grade) throws Exception {
    	if (grade == 1) {
    		List<Project> projects=commonService.selectProjectID();
    		if(projects.isEmpty()||projects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"project info", projects);
    		}
    	}else {
    		List<Project> projects=commonService.selectUserProjectID(username);
    		if(projects.isEmpty()||projects.size()==0){
    			return CommonUtil.constructResponse(0,"no record", null);
    		}else{
    			return CommonUtil.constructResponse(EnumUtil.OK,"project info", projects);
    		}
    	}
	}
    
    @RequestMapping("/showManage")
    @ResponseBody
    public JSONObject showManage() throws Exception {
		List<User> users=commonService.selectAllUser();
		if(users.isEmpty()||users.size()==0){
			return CommonUtil.constructResponse(0,"no record", null);
		}else{
			return CommonUtil.constructResponse(EnumUtil.OK,"user info", users);
		}
	}
    
    @RequestMapping("/showCollaborator")
    @ResponseBody
    public JSONObject showCollaborator() throws Exception {
		List<User> users=commonService.selectAllCollaborator();
		if(users.isEmpty()||users.size()==0){
			return CommonUtil.constructResponse(0,"no record", null);
		}else{
			return CommonUtil.constructResponse(EnumUtil.OK,"collaborator info", users);
		}
	}
    
    @RequestMapping("/addProject")
	@ResponseBody
	public JSONObject addProject(String pname,String createdby,String manageby, String collaborator, String description) throws Exception {
    	Project project=new Project();
    	project.setPname(pname);
    	project.setCreateby(createdby);
    	project.setManageby(manageby);
    	project.setCollaborator(collaborator);
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
    
    @RequestMapping("/addQuestionnaire")
	@ResponseBody
	public JSONObject addQuestionnaire(String pid,String questionnaire) throws Exception {
    	Project project=new Project();
    	project.setPid(pid);
    	project.setQuestionnaire(questionnaire);
    	List<Project> projects=commonService.checkQuestionnaire(pid);
    	if(projects.isEmpty()){
    		return CommonUtil.constructResponse(0,"Project ID not exists.", null);
    	}else{
			Integer resultOfUpdateProject=commonService.updateProject(project);
			if(resultOfUpdateProject>0){
				return CommonUtil.constructResponse(EnumUtil.OK,"update success", null);
			}else{
				return CommonUtil.constructResponse(0,"update error", null);
			}
		}
	}
    
    @RequestMapping("/addSubject")
	@ResponseBody
	public JSONObject addSubject(String subjectno,String projectid,String addby) throws Exception {
    	Subject subject=new Subject();
    	subject.setSubjectno(subjectno);
    	subject.setProjectid(projectid);
    	subject.setAddby(addby);

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
	public JSONObject addTask(String pid, String tname, String createby, String description) throws Exception {
    	Task task=new Task();
    	task.setPid(pid);
    	task.setTname(tname);
    	task.setCreateby(createby);
    	task.setDescription(description);
    	List<Task> tasks=commonService.checkTask(tname, pid);
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
	public void createTable(String fields_table) throws Exception {
    	Table table=new Table();
    	table.setdTablename(fields_table);
    	commonService.createTable(table);
	}
    
    @RequestMapping("/showFields")
    @ResponseBody
    public JSONObject showFields(int taskid) throws Exception {
		List<Table> fields=commonService.selectTaskFields(taskid);
		if(fields.isEmpty()||fields.size()==0){
			return CommonUtil.constructResponse(0,"no task fields", null);
		}else{
			return CommonUtil.constructResponse(EnumUtil.OK,"fields info", fields);
		}
	}
    
    @RequestMapping("/addField")
	@ResponseBody
	public JSONObject addField(String fieldname, String remark, int taskid) throws Exception {
    	Table table=new Table();
    	table.setFieldname(fieldname);
    	table.setRemark(remark);
    	table.setTaskid(taskid);
    	List<Table> tables=commonService.checkTable(fieldname,taskid);
    	if(tables.isEmpty()){
	    	Integer resultOfInsertFields=commonService.insertFields(table);
			if(resultOfInsertFields>0){
				return CommonUtil.constructResponse(EnumUtil.OK,"insert success", null);
			}else{
				return CommonUtil.constructResponse(0,"insert error", null);
			}
    	}else{
			return CommonUtil.constructResponse(0,"Field Name already exists", null);
		}
	}
    
    @RequestMapping("/addColumn")
	@ResponseBody
	public void addColumn(String tablename,String fieldname) throws Exception {
    	Table table=new Table();
    	table.setdTablename(tablename);
    	table.setFieldname(fieldname);
    	commonService.addColumn(table);
	}
    
    @RequestMapping("/insertField")
	@ResponseBody
	public void insertField(String tablename, String formData) throws Exception {
    	Map<String, String> map = JSON.parseObject(formData, new TypeReference<Map<String, String>>() {});
    	commonService.insertFieldValue(tablename, map);
	}
    
    @RequestMapping("/updateSubjecttasks")
	@ResponseBody
	public void updateSubjecttasks(String tablename, String subjectid, String projectid) throws Exception {
    	Subject subject=new Subject();
    	subject.setTasks(tablename);
    	subject.setSubjectid(subjectid);
    	subject.setProjectid(projectid);
    	commonService.updateSubjecttasks(subject);
	}
    
    @RequestMapping("/getSubjectTasks")
   	@ResponseBody
   	public JSONObject getSubjectTasks(String subjectid) throws Exception {
    	List<Subject> subjects = commonService.selectSubjectTasks(subjectid);
		return CommonUtil.constructResponse(EnumUtil.OK,"tasks info", subjects);
   	}
    
    @RequestMapping("/getSubjectQus")
   	@ResponseBody
   	public JSONObject getSubjectQus(String projectid) throws Exception {
    	List<Project> projects = commonService.selectSubjectQus(projectid);
		return CommonUtil.constructResponse(EnumUtil.OK,"qus info", projects);
   	}
    
    @RequestMapping("/showSubjectTasks")
	@ResponseBody
	public JSONObject showSubjectTasks(String subjectid, String tablename) throws Exception {
    	String sql = "SELECT * FROM " + tablename + " where subjectid = '" + subjectid + "'";
        List<Map<String, Object>> result = jdbcTemplate.queryForList(sql);
        if (result == null || result.isEmpty()) {
            return CommonUtil.constructResponse(0, "No tasks found", null);
        }
        return CommonUtil.constructResponse(EnumUtil.OK,"tasks info", result);
	}
    
    @RequestMapping("/showSubjectQus")
	@ResponseBody
	public JSONObject showSubjectQus(String subjectno, String tablename) throws Exception {
    	try {
	    	String sql = "SELECT * FROM " + tablename + " where subjectno = '" + subjectno + "'";
	        List<Map<String, Object>> result = jdbcTemplate.queryForList(sql);
	        if (result == null || result.isEmpty()) {
	            return CommonUtil.constructResponse(0, "No qus found", null);
	        }
	        return CommonUtil.constructResponse(EnumUtil.OK,"qus info", result);
    	} catch (Exception e) {
            return CommonUtil.constructResponse(0, "Error occurred during query execution", null);
        }
	}
    
    @RequestMapping("/deleteFields")
	@ResponseBody
	public JSONObject deleteFields(Integer id) throws Exception {
		Table table=new Table();
		table.setId(id);
		Integer resultOfDelete=commonService.deleteFields(table);
		if(resultOfDelete>0){ 
			return CommonUtil.constructResponse(EnumUtil.OK,"delete success", null);
		}else{
			return CommonUtil.constructResponse(0,"delete error", null);
		}
	}
    
    @RequestMapping("/deleteSubjectTasks")
   	@ResponseBody
   	public JSONObject deleteSubjectTasks(String id, String tablename) throws Exception {
       	String sql = "DELETE FROM " + tablename + " where id = '" + id + "'";
       	int rowsAffected = jdbcTemplate.update(sql);
       	if (rowsAffected > 0) {
       		return CommonUtil.constructResponse(EnumUtil.OK, "delete success", null);
        } else {
        	return CommonUtil.constructResponse(0, "delete error", null);
        }
   	}
    
    @RequestMapping("/deleteTasks")
   	@ResponseBody
   	public JSONObject deleteTasks(int taskid) throws Exception {
    	Task task=new Task();
    	task.setTid(taskid);
    	Integer resultOfDelete=commonService.deleteTasks(task);
		if(resultOfDelete>0){ 
			return CommonUtil.constructResponse(EnumUtil.OK,"delete success", null);
		}else{
			return CommonUtil.constructResponse(0,"delete error", null);
		}
   	}
    
    @RequestMapping("/deleteColumn")
	@ResponseBody
	public void deleteColumn(String tablename,String fieldname) throws Exception {
    	Table table=new Table();
    	table.setdTablename(tablename);
    	table.setFieldname(fieldname);
    	commonService.deleteColumn(table);
	}
    
    @RequestMapping("/checkTaskField")
	@ResponseBody
	public JSONObject checkTaskField(String tablename, String fieldname) throws Exception {
    	String sql = "SELECT COUNT(*) FROM " + tablename + " where " + fieldname + " IS NOT NULL";
    	int count = jdbcTemplate.queryForObject(sql, Integer.class);
    	if (count > 0) {
    		return CommonUtil.constructResponse(0, "Unable to delete, task data already exists.", count);
        }else {
        	return CommonUtil.constructResponse(EnumUtil.OK, "No record", null);
        }
	}
    
    @RequestMapping("/checkProjectStatus")
	@ResponseBody
	public JSONObject checkProjectStatus(String pid) throws Exception {
    	String sql = "SELECT COUNT(*) FROM subject where projectid = '" + pid + "'";
    	int count = jdbcTemplate.queryForObject(sql, Integer.class);
    	String sql2 = "SELECT COUNT(*) FROM task where pid = '" + pid + "'";
    	int count2 = jdbcTemplate.queryForObject(sql2, Integer.class);
    	int countotal = count + count2;
    	if (countotal > 0) {
    		return CommonUtil.constructResponse(0, "Unable to delete, exists subject/task data.", countotal);
        }else {
        	return CommonUtil.constructResponse(EnumUtil.OK, "No record", null);
        }
	}
    
    @RequestMapping("/CheckSubjectNo")
	@ResponseBody
	public JSONObject CheckSubjectNo(String prefix) throws Exception {
    	String sql = "SELECT COUNT(*) FROM subject where subjectno like '%" + prefix + "%'";
    	int count = jdbcTemplate.queryForObject(sql, Integer.class) + 1;
    	String sql2 = "SELECT DATE_FORMAT(CURRENT_DATE(), '%Y%m%d') AS formatted_date";
    	String date = jdbcTemplate.queryForObject(sql2, String.class);
    	String suffix = count + "_" + date;
        return CommonUtil.constructResponse(EnumUtil.OK, "", suffix);
	}
    
    @RequestMapping("/deleteProject")
   	@ResponseBody
   	public JSONObject deleteProject(String pid) throws Exception {
    	Project project=new Project();
    	project.setPid(pid);
    	Integer resultOfDelete=commonService.deleteProject(project);
		if(resultOfDelete>0){ 
			return CommonUtil.constructResponse(EnumUtil.OK,"delete success", null);
		}else{
			return CommonUtil.constructResponse(0,"delete error", null);
		}
   	}
    
    @RequestMapping("/SearchSurvey")
	@ResponseBody
	public JSONObject SearchSurvey(String pname) throws Exception {
    	try {
	    	String sql = "SELECT surveyls_survey_id FROM lime_surveys_languagesettings where surveyls_alias = '" + pname + "'";
	    	int surveyId = jdbcTemplate.queryForObject(sql, Integer.class);
	        return CommonUtil.constructResponse(EnumUtil.OK,"surveyId info", surveyId);
    	} catch (EmptyResultDataAccessException ex) {
    	    return CommonUtil.constructResponse(0, "Not found", null);
    	} catch (Exception e) {
            return CommonUtil.constructResponse(0, "Error occurred during query execution", null);
        }
	}
    
    @RequestMapping("/showSubjectSurvey")
	@ResponseBody
	public JSONObject showSubjectSurvey(String surveyid, String subjectno) throws Exception {
    	try {
	    	String sql = "SELECT id FROM lime_survey_" + surveyid + " where token = '" + subjectno + "' and submitdate is not NULL";
	    	int id = jdbcTemplate.queryForObject(sql, Integer.class);
	        return CommonUtil.constructResponse(EnumUtil.OK,"surveyId info", id);
    	} catch (EmptyResultDataAccessException ex) {
    	    return CommonUtil.constructResponse(0, "Not found", null);
    	} catch (Exception e) {
            return CommonUtil.constructResponse(0, "Error occurred during query execution", null);
        }
	}
}
