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
  .input-container {
    margin-bottom: 10px;
  }
  .input-container label {
    display: inline-block;
    width: 150px;
  }
  .hidden {
    display: none;
  }
</style>
<body>
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<div class="container">
	<div class="row clearfix">
	 	
		<div class="col-md-10">
			<button id=addProjectButton>Add Project</button>
			<div id="inputFields" class="hidden">
	                <div class="input-container">
	                    <label for="newProjectName">Name:</label>
	                    <input type="text" id="newProjectName" name="newProjectName">
	                </div>

	                <div class="input-container">
	                    <label for="newProjectManageBy">Manage By:</label>
	                    <input type="text" id="newProjectManageBy" name="newProjectManageBy">
	                </div>

	                <div class="input-container">
	                    <label for="newProjectDescription">Description:</label>
	                    <input type="text" id="newProjectDescription" name="newProjectDescription">
	                </div>
	                <button id="saveProjectButton">Save</button>
	            </div>
           <table class="table">
			<thead>
				<tr>
					<th>Project_ID</th>
					<th>Project_Name</th>
					<th>Project_Descriptions</th>
					<th>Project_Manage_By</th>
					<th>Project_Created_By</th>
					<th>Project_Created_date</th>
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
	$("#addProjectButton").click(function() {
        showInputFields(); 
    });
    
    $("#saveProjectButton").click(function() {
        saveNewProject();
    });
    
    function showInputFields() {
        $("#inputFields").removeClass("hidden");
    }
    
    function saveNewProject() {
        var pname = $("#newProjectName").val();
        var createdby = "<%=Username%>"
        var manageby = $("#newProjectManageBy").val();
        var description = $("#newProjectDescription").val();
        if(pname == ""){
			alert("Please input project name")
		}else if(manageby == ""){
			alert("Please input the manager name")
		}else{
	        $.ajax({ 
				url:"./addProject",
				type:"POST", 
				datatype:"json",
				data:{"pname":pname,"createdby":createdby,"manageby":manageby,"description":description},	 
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
					}else if(data.code==0){
						alert(data.msg)
					}
				}
			})

	        $("#newProjectName").val("");
	        $("#newProjectManageBy").val("");
	        $("#newProjectDescription").val("");
	        $("#inputFields").addClass("hidden");
	        
	        location.reload();
        }
    }
    
    
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
	 				var createby = document.createTextNode(dataList[i].createby);
	 				var manageby = document.createTextNode(dataList[i].manageby);
	 				
	 				var date = new Date(dataList[i].createdate);
					Y = date.getFullYear() + '-';
					M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
					D = date.getDate() + ' ';
					transferdate = Y+M+D;
	 				
	 				var description = document.createTextNode(dataList[i].description);
	 				
	 				var newLink = document.createElement("a");
					newLink.href = "subjectlist?pid=" + dataList[i].pid;
					newLink.text = dataList[i].pname;
					
	 				newTdRow1.append(pid);
	 				newTdRow2.append(newLink);
	 				newTdRow3.append(description);
	 				newTdRow4.append(manageby);
	 				newTdRow5.append(createby);
	 				newTdRow6.append(transferdate);
	 				
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