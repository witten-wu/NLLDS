<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Test</title>
  <style>
    body {
      font-family: Arial, sans-serif;
    }
    .container {
      max-width: 300px;
      margin: 0 auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #f9f9f9;
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
    .btn {
      display: block;
      width: 100%;
      padding: 10px;
      border: none;
      border-radius: 3px;
      background-color: #4caf50;
      color: white;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
    }
    .btn:hover {
      background-color: #45a049;
    }
  </style>
</head>

<body>

  <%User user =(User)session.getAttribute("user");%>
  <div class="container">
  	<button type="button" class="btn" id="login">Test</button>
  </div>

</body>
</html>