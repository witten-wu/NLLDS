<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Questionnaire</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
<style>
.quscontainer {
  max-width: 1920px;
  margin: 0 auto;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
html, body {
  background-color: lightgray;
  height: 100%;
  margin: 0;
  padding: 0;
}
</style>
</head>
<body>
<div class="quscontainer">
	<iframe id="dynamic-iframe" width="900px" height="900px" frameborder="0" marginwidth="0" marginheight="0" style="border: none; max-width:100%; max-height:100vh" allowfullscreen webkitallowfullscreen mozallowfullscreen msallowfullscreen> </iframe>
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
					alert(data.msg);
				}
			}
		});
	});
</script>
</body>
</html>    