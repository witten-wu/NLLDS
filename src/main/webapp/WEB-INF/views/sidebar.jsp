<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<%int Grade = ((User)session.getAttribute("user")).getGrade();%>
	<aside class="box" id="sidebox">
		<div class="logo">
          <img src="bootstrap/css/cuhkico.png" alt="Logo" width="150" height="135">
        </div>
        <button id="sidebtn">三</button>
        <ul>
            <li><a href="projectlist">Project</a></li>
            <li><a href="tasklist">Task</a></li>
            <li><a href="/limesurvey/index.php?r=admin/authentication/sa/login" target="_blank">Survey</a></li>
            <% if (Grade == 1) { %>
			    <li><a href="/elFinder/elfinder.html" target="_blank">FTPServer</a></li>
			<% } %>
		    <!-- <li><a href="questionnaire">Questionnaire</a></li> -->
        </ul>
    </aside>

</body>
</html>