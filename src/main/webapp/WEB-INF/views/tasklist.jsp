<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Task</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<%int Grade = ((User)session.getAttribute("user")).getGrade();%>
<jsp:include page="sidebar.jsp" />
<div class="container">
	<div class="row clearfix" style="width:100%">
		<div class="col-md-10" style="width:100%">
			<button id=addTaskButton style="margin-bottom: 10px;">Add Task</button>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
					<div class="input-container">
	                    <label for="newPId">Project:</label>
	                    <select id="newPId" name="newPId"> 
					    	<option value="">Please Select</option>
					    </select>
	                </div>
	                
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
	       <div class="table-container">
	           <table class="table" style="margin-bottom: 10px;">
				<thead style="background-color: #000000; color: white;">
					<tr>
						<th>Project</th>
						<!-- <th>Task_ID</th> -->
						<th>Task Name</th>
						<th>Descriptions</th>
						<th>Created By</th>
						<th>Created date</th>
						<!-- <th>Task_Fields</th> -->
					</tr>
				</thead>
				<tbody id="showtasklist">
				</tbody>
			   </table>
		   </div>
        </div>
	</div>
</div>
<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var box = document.getElementById("sidebox")
	var btn = document.getElementById("sidebtn")
	btn.onclick = function() {
	    if (box.offsetLeft == 0) {
	        box.style['margin-left'] = -150 + "px"
	    } else {
	        box.style['margin-left'] = 0 + "px"
	    }
	}
$(document).ready(function(){
	var Username = "<%=Username%>";
    var Grade = <%=Grade%>;
	
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
        /* var fields_table = tname + '_template' */
        var pid = $("#newPId option:selected").val();
        if(pid == ""){
			alert("Please select the Project ID")
		}else if(tname == ""){
			alert("Please input task name")
		}else{
	        $.ajax({ 
				url:"./addTask",
				type:"POST", 
				datatype:"json",
				data:{"pid":pid,"tname":tname,"createby":createby,"description":description},
				/* data:{"tname":tname,"createby":createby,"description":description,"fields_table":fields_table}, */
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
							/* $.ajax({ 
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
						}) */
						$("#newPId").val("");
						$("#newTaskName").val("");
				        $("#newTaskDescription").val("");
				        $("#inputFields").addClass("hidden");
				        location.reload();
					}else if(data.code==0){
						alert(data.msg);
					}
				}
			})
        }
    }
    
    /* function redirectToNewPage(taskid, tablename) {
   	  var url = "taskfields?tid=" + taskid + "&table=" + tablename;
   	  window.location.href = url;
   	} */
   	
   	$.ajax({
		url:"./showProjectID",
		type:"POST", 
		datatype:"json",
		data:{"username":Username, "grade":Grade},
		async:"false",
		success:function(data){
			data = JSON.parse(data); 
			dataList = data.data; 
			if(data.code==1){
				for(var i=0;i < dataList.length;i++){
					var newRow = document.createElement("option");
					var pid = document.createTextNode(dataList[i].pid);
					newRow.append(pid);
					newRow.value=dataList[i].pid;
					$("#newPId").append(newRow);
				}
			}
		}
	});
   	
   	
   	function showContextMenu(x, y, taskid) {
	    var menu = document.createElement("ul");
	    menu.className = "context-menu";
	    menu.innerHTML = "<li>Delete</li>";
	    menu.querySelector("li").addEventListener("click", function () {
	      deleteTasks(taskid); 
	      menu.remove(); 
	    });
	    menu.style.left = x + "px";
	    menu.style.top = y + "px";
	    document.body.appendChild(menu);
	    document.addEventListener("mousedown", function (event) {
	      var target = event.target;
	      if (!menu.contains(target)) {
	        menu.remove();
	        var selectedTr = document.querySelector("tr.selected-row");
	        if (selectedTr) {
	          selectedTr.classList.remove("selected-row");
	        }
	      }
	    });
	}
   	
   	function deleteTasks(taskid) {
    	$.ajax({ 
    		url:"./deleteTasks",
    		type:"POST", 
    		datatype:"json",	 
    		data:{"taskid":taskid},	
    		async:"false",
    		success:function(data){
    			data = JSON.parse(data); 
    			dataList = data.data; 
    			if(data.code==1){
    				location.reload();
    			}else if(data.code==0){
    				alert(data.msg);
    			}
    		}
    	});
    }
   	
	$.ajax({ 
		url:"./showTaskList",
		type:"POST", 
		datatype:"json",
		data:{"username":Username, "grade":Grade},
		async:"false",
		success:function(data){
			var str =""; 
			data = JSON.parse(data); 
			dataList = data.data; 
			if(data.code==1){
				for(var i=0;i<dataList.length;i++){
					var newTrRow = document.createElement("tr");
					
					/* (function (taskid, tablename) {
			            newTrRow.addEventListener("dblclick", function () {
			            	redirectToNewPage(taskid, tablename);
			            });
			        })(dataList[i].tid, dataList[i].fields_table);  */
			        
					(function (taskid) {
			        	newTrRow.addEventListener("contextmenu", function (e) {
				          e.preventDefault();
				          showContextMenu(e.clientX, e.clientY, taskid);
				          $("tbody#showtasklist tr").removeClass("selected-row");
				          this.classList.add("selected-row");
				        });
			        })(dataList[i].tid); 
					
			        var newTdRow0 = document.createElement("td");
	 				/* var newTdRow1 = document.createElement("td"); */
	 				var newTdRow2 = document.createElement("td");
	 				var newTdRow3 = document.createElement("td");
	 				var newTdRow4 = document.createElement("td");
	 				var newTdRow5 = document.createElement("td");
	 				/* var newTdRow6 = document.createElement("td"); */
	 				
	 				var pid = document.createTextNode(dataList[i].pid);
	 				/* var tid = document.createTextNode(dataList[i].tid); */
	 				var tname = document.createTextNode(dataList[i].tname);
	 				var description = document.createTextNode(dataList[i].description);
	 				var createby = document.createTextNode(dataList[i].createby);
	 				
	 				var date = new Date(dataList[i].createdate);
					Y = date.getFullYear() + '-';
					M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
					D = date.getDate() + ' ';
					transferdate = Y+M+D;
	 				
	 				/* var newLink = document.createElement("a");
					newLink.href = "taskfields?tid=" + dataList[i].tid + "&table=" + dataList[i].fields_table;
					newLink.text = "detail..."; */
					
					newTdRow0.append(pid);
	 				/* newTdRow1.append(tid); */
	 				newTdRow2.append(tname);
	 				newTdRow3.append(description);
	 				newTdRow4.append(createby);
	 				newTdRow5.append(transferdate);
	 				/* newTdRow6.append(newLink); */
	 				
	 				newTrRow.append(newTdRow0);
	 				/* newTrRow.append(newTdRow1); */
	 				newTrRow.append(newTdRow2);
	 				newTrRow.append(newTdRow3);
	 				newTrRow.append(newTdRow4);
	 				newTrRow.append(newTdRow5);
	 				/* newTrRow.append(newTdRow6); */
	 				
	 				$("tbody#showtasklist").append(newTrRow);
	 			}
			}
		}
	});
});
</script>
</body>
</html>    