<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Project</title>
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
  
  /* 按钮样式 */
  button {
    padding: 10px 20px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  button:hover {
    background-color: #45a049;
  }
</style>
<body>
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<div class="container">
	<jsp:include page="sidebar.jsp" />
	<div class="row clearfix">
	 	
		<div class="col-md-10">
			<button id=addProjectButton style="margin-bottom: 10px;">Add Project</button>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
	                <div class="input-container">
	                    <label for="newProjectName">Project Name:</label>
	                    <input type="text" id="newProjectName" name="newProjectName">
	                    <span id="newProjectNameError" style="color: red;"></span>
	                </div>

	                <div class="input-container">
	                    <label for="newProjectManageBy">Manage By:</label>
	                    <input type="text" id="newProjectManageBy" name="newProjectManageBy">
	                </div>

	                <div class="input-container">
	                    <label for="newProjectDescription">Description:</label>
	                    <input type="text" id="newProjectDescription" name="newProjectDescription">
	                </div>
	                <button id="saveProjectButton" style="margin-bottom: 10px;">Save</button>
	            </div>
           <table class="table" style="margin-bottom: 10px;">
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

	var newProjectNameInput = document.getElementById('newProjectName');
    var newProjectNameError = document.getElementById('newProjectNameError');
    var saveProjectButton = document.getElementById('saveProjectButton');

    newProjectNameInput.addEventListener('input', function() {
        var value = newProjectNameInput.value;
        if (/[\u4e00-\u9fa5]/.test(value)) {
            newProjectNameError.textContent = 'Please enter a valid Project Name';
            saveProjectButton.disabled = true;
        } else {
            newProjectNameError.textContent = '';
            saveProjectButton.disabled = false;
        }
    });

	$("#addProjectButton").click(function() {
        $("#inputFields").toggleClass("hidden");
    });
    
    $("#saveProjectButton").click(function() {
        saveNewProject();
    });
    
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
</body>
</html>    