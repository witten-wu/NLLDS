<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Questionnaire</title>
</head>
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
    padding: 5px;
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

  .selected-row {
  	background-color: #2d72d2;
  	color: white;
  }
</style>
<body>
<div class="container">
	<iframe id="dynamic-iframe" width="640" height="954" frameborder="0" marginheight="0" marginwidth="0">正在載入…</iframe>
</div>
<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">

	var value = window.location.search.substr(1);
	var pid = value.split('=')[1];

	$(document).ready(function(){
		$.ajax({ 
			url:"./getQuestionnaire",
			type:"POST", 
			datatype:"json",
			data:{"pid":pid},	 
			async:"false",
			success:function(data){
				var str =""; 
				data = JSON.parse(data); 
				dataList = data.data; 
				if(data.code==1){
					for(var i=0;i<dataList.length;i++){
		 				var qusurl = dataList[i].questionnaire;
		 				var iframe = document.getElementById("dynamic-iframe");
		 				iframe.src = qusurl;
		 			}
				}else if(data.code==0){
					alert(data.msg)
				}
			}
		});
	});
</script>
</body>
</html>    