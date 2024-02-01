<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Project</title>
</head>
<style>
  .table th,
  .table td {
    padding: 10px;
    text-align: left;
  }
</style>
<body>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-10">
           <table class="table">
			<thead>
				<tr>
					<th>Project_ID</th>
					<th>Project_Name</th>
					<th>Project_Created_By</th>
					<th>Project_Manage_By</th>
					<th>Project_Created_date</th>
					<th>Project_Descriptions</th>
				</tr>
			</thead>
			<tbody id="showprojectlist">
			</tbody>
		   </table>
        </div>
	</div>
</div>
<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({ 
		url:"./showProjectList",
		type:"POST", 
		datatype:"json",	 
		async:"false",
		success:function(data){
			var str =""; 
			data = JSON.parse(data); 
			dataList = data.data; 
			if(data.code==1){
				for(var i=0;i<dataList.length;i++){
					var newTrRow = document.createElement("tr");
	 				var newTdRow1 = document.createElement("td");
	 				var newTdRow2 = document.createElement("td");
	 				var newTdRow3 = document.createElement("td");
	 				var newTdRow4 = document.createElement("td");
	 				var newTdRow5 = document.createElement("td");
	 				var newTdRow6 = document.createElement("td");
	 				
	 				var pid = document.createTextNode(dataList[i].pid);
	 				var pname = document.createTextNode(dataList[i].pname);
	 				var createby = document.createTextNode(dataList[i].createby);
	 				var manageby = document.createTextNode(dataList[i].manageby);
	 				var createdate = document.createTextNode(dataList[i].createdate);
	 				var description = document.createTextNode(dataList[i].description);
	 				
	 				var newLink = document.createElement("a");
					newLink.href = "subjectlist?pid=" + dataList[i].pid;
					newLink.text = dataList[i].pname;
					
	 				newTdRow1.append(pid);
	 				newTdRow2.append(newLink);
	 				newTdRow3.append(createby);
	 				newTdRow4.append(manageby);
	 				newTdRow5.append(createdate);
	 				newTdRow6.append(description);
	 				
	 				newTrRow.append(newTdRow1);
	 				newTrRow.append(newTdRow2);
	 				newTrRow.append(newTdRow3);
	 				newTrRow.append(newTdRow4);
	 				newTrRow.append(newTdRow5);
	 				newTrRow.append(newTdRow6);
	 				
	 				$("tbody#showprojectlist").append(newTrRow);
	 			}
			}else if(data.code==0){
				alert(data.msg)
			}
		}
	});
});
</script>
</html>    