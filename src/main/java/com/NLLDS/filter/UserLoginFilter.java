package com.NLLDS.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.NLLDS.model.User;


@WebFilter({"/projectlist", "/subjectlist", "/tasklist", "/taskfields", "/subjectask", "/subjectquestionnaire", "/questionnaire"})
public class UserLoginFilter implements Filter {
	
    public UserLoginFilter() {
    }
    
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse httpResponse=(HttpServletResponse) response;
		httpResponse.setContentType("text/html;charset=utf-8");
		String itemName=request.getServletContext().getContextPath();
		User user = (User) req.getSession().getAttribute("user");
		if(user==null){
			response.getWriter().print("Please Login!");
			String path=itemName+"/login";
			httpResponse.setHeader("Refresh", "0.5;URL="+path);
			return;
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
