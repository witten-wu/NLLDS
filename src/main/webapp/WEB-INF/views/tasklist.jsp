<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Task</title>
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
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<div class="container">
	<jsp:include page="sidebar.jsp" />
	<div class="row clearfix">
		<div class="col-md-10">
			<button id=addTaskButton style="margin-bottom: 10px;">Add Task</button>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
	                <div class="input-container">
	                    <label for="newTaskName">Task Name:</label>
	                    <input type="text" id="newTaskName" name="newTaskName">
	                    <span id="newTaskNameError" style="color: red;"></span>
	                </div>

	                <div class="input-container">
	                    <label for="newTaskDescription">Description:</label>
	                    <input type="text" id="newTaskDescription" name="newTaskDescription">
	                </div>
	                <button id="saveTaskButton" style="margin-bottom: 10px;">Save</button>
	            </div>
           <table class="table" style="margin-bottom: 10px;">
			<thead>
				<tr>
					<th>Task_ID</th>
					<th>Task_Name</th>
					<th>Task_Descriptions</th>
					<th>Task_Created_By</th>
					<th>Task_Created_date</th>
					<th>Task_Fields</th>
				</tr>
			</thead>
			<tbody id="showtasklist">
			</tbody>
		   </table>
        </div>
	</div>
</div>
<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var newTaskNameInput = document.getElementById('newTaskName');
    var newTaskNameError = document.getElementById('newTaskNameError');
    var saveTaskButton = document.getElementById('saveTaskButton');

    newTaskNameInput.addEventListener('input', function() {
        var value = newTaskNameInput.value;
        var isValid = /^[a-zA-Z_][a-zA-Z0-9_]*$/.test(value);
        if (!isValid) {
            newTaskNameError.textContent = 'Please enter a valid task name';
            saveTaskButton.disabled = true;
        } else {
            newTaskNameError.textContent = '';
            saveTaskButton.disabled = false;
        }
    });
	$("#addTaskButton").click(function() {
        $("#inputFields").toggleClass("hidden");
    });
    
    $("#saveTaskButton").click(function() {
        saveNewTask();
    });
    
    $("tbody#showtasklist").on("click", "tr", function() {
   	  $("tbody#showtasklist tr").removeClass("selected-row");
   	  $(this).addClass("selected-row");
   	});
    
    function saveNewTask() {
        var tname = $("#newTaskName").val();
        var createby = "<%=Username%>"
        var description = $("#newTaskDescription").val();
        var fields_table = tname + '_template'
        if(tname == ""){
			alert("Please input task name")
		}else{
	        $.ajax({ 
				url:"./addTask",
				type:"POST", 
				datatype:"json",
				data:{"tname":tname,"createby":createby,"description":description,"fields_table":fields_table},	 
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
							$.ajax({ 
							url:"./createTable",
							type:"POST", 
							datatype:"json",
							data:{"fields_table":fields_table},	
							success:function(){
								$("#newTaskName").val("");
						        $("#newTaskDescription").val("");
						        $("#inputFields").addClass("hidden");
						        location.reload();
							}
						})
					}else if(data.code==0){
						alert(data.msg)
					}
				}
			})  
        }
    }
    
    function redirectToNewPage(taskid, tablename) {
   	  var url = "taskfields?tid=" + taskid + "&table=" + tablename;
   	  window.location.href = url;
   	}
    
	$.ajax({ 
		url:"./showTaskList",
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
					
					(function (taskid, tablename) {
			            newTrRow.addEventListener("dblclick", function () {
			            	redirectToNewPage(taskid, tablename);
			            });
			        })(dataList[i].tid, dataList[i].fields_table); 
					
	 				var newTdRow1 = document.createElement("td");
	 				var newTdRow2 = document.createElement("td");
	 				var newTdRow3 = document.createElement("td");
	 				var newTdRow4 = document.createElement("td");
	 				var newTdRow5 = document.createElement("td");
	 				var newTdRow6 = document.createElement("td");
	 				
	 				var tid = document.createTextNode(dataList[i].tid);
	 				var tname = document.createTextNode(dataList[i].tname);
	 				var description = document.createTextNode(dataList[i].description);
	 				var createby = document.createTextNode(dataList[i].createby);
	 				
	 				var date = new Date(dataList[i].createdate);
					Y = date.getFullYear() + '-';
					M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
					D = date.getDate() + ' ';
					transferdate = Y+M+D;
	 				
	 				var newLink = document.createElement("a");
					newLink.href = "taskfields?tid=" + dataList[i].tid + "&table=" + dataList[i].fields_table;
					newLink.text = "detail...";
					
	 				newTdRow1.append(tid);
	 				newTdRow2.append(tname);
	 				newTdRow3.append(description);
	 				newTdRow4.append(createby);
	 				newTdRow5.append(transferdate);
	 				newTdRow6.append(newLink);
	 				
	 				newTrRow.append(newTdRow1);
	 				newTrRow.append(newTdRow2);
	 				newTrRow.append(newTdRow3);
	 				newTrRow.append(newTdRow4);
	 				newTrRow.append(newTdRow5);
	 				newTrRow.append(newTdRow6);
	 				
	 				$("tbody#showtasklist").append(newTrRow);
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