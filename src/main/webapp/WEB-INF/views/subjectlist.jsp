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
					<th>Subject_ID</th>
					<th>Subject</th>
					<th>Questionnaire</th>
					<th>Tasks</th>
					<th>File</th>
				</tr>
			</thead>
			<tbody id="showsubjectlist">
			</tbody>
		   </table>
        </div>
	</div>
	<ul id="file-list"></ul>
</div>
<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var value = window.location.search.substr(1);
	var pid = value.split('=')[1];
	$.ajax({ 
		url:"./showSubjectList",
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
					var newTrRow = document.createElement("tr");
	 				var newTdRow1 = document.createElement("td");
	 				var newTdRow2 = document.createElement("td");
	 				var newTdRow3 = document.createElement("td");
	 				var newTdRow4 = document.createElement("td");
	 				var newTdRow5 = document.createElement("td");
	 				
	 				var subjectid = document.createTextNode(dataList[i].subjectid);
	 				var subjectno = document.createTextNode(dataList[i].subjectno);
	 				
	 				var newLink = document.createElement("a");
					newLink.href = "questionnaire?id=";
					newLink.text = "Null"
					
					var newLink2 = document.createElement("a");
					newLink2.href = "task?id=";
					newLink2.text = "Task...";
	 				
	 				var viewButton = document.createElement("button");
	 				viewButton.innerText = "view";
	 				
	 				viewButton.addEventListener("click", function() {
					    loginToFilestash();
					});
	 				
	 				newTdRow1.append(subjectid);
	 				newTdRow2.append(subjectno);
	 				newTdRow3.append(newLink);
	 				newTdRow4.append(newLink2);

	 				newTdRow5.append(viewButton);
	 				
	 				newTrRow.append(newTdRow1);
	 				newTrRow.append(newTdRow2);
	 				newTrRow.append(newTdRow3);
	 				newTrRow.append(newTdRow4);
	 				newTrRow.append(newTdRow5);
	 				
	 				$("tbody#showsubjectlist").append(newTrRow);
	 			}
			}else if(data.code==0){
				alert(data.msg)
			}
		}
	});
});

	function loginToFilestash() {
    	window.open("http://192.168.1.221:8334/files/home/wyd/NLLDS/")
    }
</script>
</html>    