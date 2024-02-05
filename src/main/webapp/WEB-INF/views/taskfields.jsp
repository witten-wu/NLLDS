<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>TaskDesign</title>
  <link rel="stylesheet" type="text/css" href="style.css">
  <style>
  /* 全局样式 */
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }
  
  /* 容器样式 */
  .container {
    max-width: 960px;
    margin: 0 auto;
    padding: 20px;
  }
  
  /* 表格样式 */
  .table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
  }
  .table th,
  .table td {
    padding: 10px;
    text-align: left;
    border: 1px solid #ccc;
  }
  
  /* 输入字段样式 */
  .input-container {
    margin-bottom: 10px;
  }
  .input-container label {
    display: inline-block;
    width: 150px;
    font-weight: bold;
  }
  .input-container input[type="text"] {
    width: 300px;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  
  /* 隐藏内容样式 */
  .hidden {
    display: none;
  }
  
  button {

    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  
  </style>
</head>
<body>
<div class="container">
  <jsp:include page="sidebar.jsp" />
  <div class="row clearfix">
	<div class="col-md-10">
	    <form id="add-field-form" style="margin-bottom: 10px;">
	      <label for="field-name">Field Name:</label>
	      <input type="text" id="field-name" required>
	
	      <label for="data-type">DataType:</label>
	      <input type="text" id="data-type" required>
	      
	      <label for="field-length">Length:</label>
	      <input type="text" id="field-length">
	
	      <button type="submit">Add</button>
	    </form>    
	  	<table class="table" style="margin-bottom: 10px;">
			<thead>
				<tr>
					<th>Field_Name</th>
					<th>DataType</th>
					<th>Length</th>
				</tr>
			</thead>
			<tbody id="showfields">
			</tbody>
	    </table>
	</div>
  </div>
</div>
</body>
</html>