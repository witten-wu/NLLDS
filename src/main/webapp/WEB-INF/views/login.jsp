<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <style>
    body {
      display: flex;
  	  justify-content: center;
  	  align-items: center;
  	  margin: 100px;
      font-family: Arial, sans-serif;
    }
    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #f9f9f9;
    }
    form {
	  width: 300px;
	  /* other styles */
	}
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-group input {
      width: 100%;
      padding: 5px;
      border: 1px solid #ccc;
      border-radius: 3px;
    }
    
  </style>
</head>

<body>
  <%User user =(User)session.getAttribute("user");%>
  <div class="container">
    <form>
      <div class="form-group">
        <label for="username">Username:</label>
        <input type="text" id="username" placeholder="Enter your username">
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" id="password" placeholder="Enter your password">
      </div>
      <button type="button" class="btn" id="login">Login</button>	
    </form>
  </div>

<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#login").click(function(){
		var username = $("#username").val();
		var password = $("#password").val();
		$.ajax({
			url:"./loginclick",
			type:"POST",
			data:{"username":username,"password":password},
			datatype:"json",
			success:function(data){
				data=JSON.parse(data);
				if(data.code==1){
					window.history.replaceState(null, "", "projectlist");
					window.location.href="projectlist"
				}else{
					alert(data.msg)
				}
			}
		});
	});
});
</script>
</body>
</html>