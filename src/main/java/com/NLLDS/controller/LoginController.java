package com.NLLDS.controller;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.NLLDS.model.User;
import com.NLLDS.util.CommonUtil;
import com.NLLDS.util.EnumUtil;
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
    
    @RequestMapping("/test")
    public String test() {
        return "test";
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
}
