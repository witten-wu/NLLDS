<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <style>
  *, *:after, *:before {
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    box-sizing: border-box;
	}
	.login-title {
      text-align: center;
	  margin-bottom: 20px;
	  font-size: 17px;
	  font-weight: bold;
	  color: #000;
	  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
	  font-family: 'Georgia', serif;
	  letter-spacing: 2px;
	}
	.login {
	    width: 300px;
	    margin: 10% auto;
	}
	.login form {
	  width: 100%;
	}
	input {
	    border: 2px solid rgba(0, 0, 0, 1);
	    box-shadow: 0 -5px 45px rgba(100, 100, 100, 0.2) inset, 0 1px 1px rgba(255, 255, 255, 0.2);
	    margin-bottom: 10px;
	    outline: medium none;
	    padding: 10px;
	    font-family: 'Georgia', serif;
	    font-size: 12px;
	    font-weight: bold;
	    text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
	    width: 100%;
	}
	
	button {
	    background: Black;
	    font-family: 'Georgia', serif;
	    font-size: 12px;
	    font-weight: bold;
	    color: #FFFFFF;
	    padding: 10px 25px;
	    width: 100%;
	    cursor: pointer;
	}
  </style>
</head>

<body>
  <%User user =(User)session.getAttribute("user");%>
  <div class="login">
    <div class="login-title">NLL Data System</div>
  	<form>
	    <input type="text" id="username" placeholder="Enter your Username">
	    <input type="password" id="password" placeholder="Enter your Password">
	    <button type="button" class="btn" id="login">Login</button>	
    </form>
  </div>

<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#login").click(function(){
		login();
	});
	
	$("#password").keypress(function(event) {
		if (event.which === 13) {
			login();
		}
	});
	
	function login() {
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
					alert(data.msg);
				}
			}
		});
	}
});
</script>
</body>
</html>