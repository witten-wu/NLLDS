<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Project</title>
<link href="bootstrap/css/select2.min.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<%int Grade = ((User)session.getAttribute("user")).getGrade();%>
<jsp:include page="sidebar.jsp" />
<div class="container">
	<div class="row clearfix">
		<div class="col-md-10">
			<% if (Grade == 1) { %>
				<button id=addProjectButton style="margin-bottom: 10px;">Add Project</button>
			<% } %>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
	                <div class="input-container">
	                    <label for="newProjectName">Project Name:</label>
	                    <input type="text" id="newProjectName" name="newProjectName">
	                    <span id="newProjectNameError" style="color: red;"></span>
	                </div>

	                <div class="input-container">
	                    <label for="newProjectDescription">Description:</label>
	                    <input type="text" id="newProjectDescription" name="newProjectDescription">
	                </div>
	                
	                <div class="input-container">
	                    <label for="newProjectManageBy">Manage By:</label>
	                    <select class="js-example-basic-multiple" id="newProjectManageBy" name="newProjectManageBy" multiple="multiple">
					    </select>
	                </div>
	                
	                <div class="input-container">
	                    <label for="newProjectCollaborator">Collaborator:</label>
	                    <select class="js-example-basic-multiple" id="newProjectCollaborator" name="newProjectCollaborator" multiple="multiple">
					    </select>
	                </div>
	                <button id="saveProjectButton" style="margin-bottom: 10px;">Save</button>
	            </div>
           <table class="table" style="margin-bottom: 10px;">
			<thead>
				<tr>
					<th>Project_ID</th>
					<th>Project_Name</th>
					<th>Survey_ID</th>
					<th>Descriptions</th>
					<th>Manage_By</th>
					<th>Collaborator</th>
					<th>Created_By</th>
					<th>Created_date</th>
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
<script src="bootstrap/js/select2.min.js"></script>
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
	var newProjectNameInput = document.getElementById('newProjectName');
    var newProjectNameError = document.getElementById('newProjectNameError');
    var saveProjectButton = document.getElementById('saveProjectButton');
    var Username = "<%=Username%>";
    var Grade = <%=Grade%>;

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
    
    $('#newProjectManageBy').select2({
    	width: '200px',
        dropdownAutoWidth: true
      });
    
    $('#newProjectCollaborator').select2({
    	width: '200px',
        dropdownAutoWidth: true
      });

	$("#addProjectButton").click(function() {
        $("#inputFields").toggleClass("hidden");
    });
    
    $("#saveProjectButton").click(function() {
        saveNewProject();
    });
    
    $("tbody#showprojectlist").on("click", "tr", function() {
   	  $("tbody#showprojectlist tr").removeClass("selected-row");
   	  $(this).addClass("selected-row");
   	});
    
    function saveNewProject() {
        var pname = $("#newProjectName").val();
        var createdby = "<%=Username%>"
        var manageby = $("#newProjectManageBy").val();
        var manageby = manageby.join(",");
        var collaborator = $("#newProjectCollaborator").val();
        var collaborator = collaborator.join(",");
        var description = $("#newProjectDescription").val();
        if(pname == ""){
			alert("Please input the project name")
		}else if(manageby == ""){
			alert("Please select the manager")
		}else if(collaborator == ""){
			alert("Please select the collaborator")
		}else{
	        $.ajax({ 
				url:"./addProject",
				type:"POST", 
				datatype:"json",
				data:{"pname":pname,"createdby":createdby,"manageby":manageby, "collaborator":collaborator, "description":description},	 
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
						$("#newProjectName").val("");
				        $("#newProjectManageBy").val("");
				        $("#newProjectCollaborator").val("");
				        $("#newProjectDescription").val("");
				        $("#inputFields").addClass("hidden");
				        location.reload();
					}else if(data.code==0){
						alert(data.msg);
					}
				}
			})
        }
    }
    
    function redirectToNewPage(projectId,projectName,SurveyId) {
   	  var url = "subjectlist?pid=" + projectId + "&pname=" + projectName + "&surveyid=" + SurveyId;
   	  window.location.href = url;
   	}
    
    
    $.ajax({
		url:"./showManage",
		type:"POST", 
		datatype:"json",
		async:"false",
		success:function(data){
			data = JSON.parse(data); 
			dataList = data.data; 
			var firstOption = document.createElement("option");
	        firstOption.value = "N/A";
	        firstOption.text = "N/A";
	        $("#newProjectManageBy").append(firstOption);
	        if(data.code==1){
	        	for(var i=0;i < dataList.length;i++){
					var newRow = document.createElement("option");
					var username = document.createTextNode(dataList[i].username);
					newRow.append(username);
					newRow.value=dataList[i].username;
					$("#newProjectManageBy").append(newRow);
				}
	        }
		}
	});
    
    $.ajax({
		url:"./showCollaborator",
		type:"POST", 
		datatype:"json",
		async:"false",
		success:function(data){
			data = JSON.parse(data); 
			dataList = data.data; 
	        var firstOption = document.createElement("option");
	        firstOption.value = "N/A";
	        firstOption.text = "N/A";
	        $("#newProjectCollaborator").append(firstOption);
	        if(data.code==1){
	        	for(var i=0;i < dataList.length;i++){
					var newRow = document.createElement("option");
					var username = document.createTextNode(dataList[i].username + " (" + dataList[i].region + ")");
					newRow.append(username);
					newRow.value=dataList[i].username;
					$("#newProjectCollaborator").append(newRow);
				}
	        }
		}
	});
    
    
    function showContextMenu(x, y, pid) {
	    var menu = document.createElement("ul");
	    menu.className = "context-menu";
	    menu.innerHTML = "<li>delete</li>";
	    menu.querySelector("li").addEventListener("click", function () {
	      deleteProject(pid); 
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
   	
    function deleteProject(pid) {
    	$.ajax({ 
    		url:"./checkProjectStatus",
    		type:"POST", 
    		datatype:"json",	 
    		data:{"pid":pid},	
    		success:function(data){
    			data = JSON.parse(data); 
    			if(data.code==1){
    				$.ajax({ 
    		    		url:"./deleteProject",
    		    		type:"POST", 
    		    		datatype:"json",	 
    		    		data:{"pid":pid},	
    		    		async:"false",
    		    		success:function(data){
    		    			data = JSON.parse(data); 
    		    			if(data.code==1){
    		    				location.reload();
    		    			}else if(data.code==0){
    		    				alert(data.msg);
    		    			}
    		    		}
    		    	});
    			}else if(data.code==0){
    				alert(data.msg);
    			}
    		}
    	});
    }
    
    
	$.ajax({ 
		url:"./showProjectList",
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
	 				(function (pname, pid, createby, manageby, collaborator, createdate, description) {
			        	$.ajax({
		        	      url: "./SearchSurvey",
		        	      type: "POST",
		        	      dataType: "json",
		        	      data: {"pname": pname},
		        	      success: function(response) {
		        	    	var newTrRow = document.createElement("tr");
		        	    	
		        	    	newTrRow.addEventListener("contextmenu", function (e) {
					          e.preventDefault();
					          showContextMenu(e.clientX, e.clientY, pid);
					          $("tbody#showprojectlist tr").removeClass("selected-row");
					          this.classList.add("selected-row");
					        });

		        	    	var newTdRow1 = document.createElement("td");
			 				var newTdRow2 = document.createElement("td");
			 				var newTdRow3 = document.createElement("td");
			 				var newTdRow4 = document.createElement("td");
			 				var newTdRow5 = document.createElement("td");
			 				var newTdRow6 = document.createElement("td");
			 				var newTdRow7 = document.createElement("td");
			 				var newTdRow8 = document.createElement("td");
			 				
			 				var surveyid = "";
			 				if (response.code == 1) {
							  // assume only 1 record return and return "surveyls_alias"
							  surveyid = response.data;
							  var newLink2 = document.createElement("a");
							  newLink2.href = "/limesurvey/?r=" + pname;
							  newLink2.target = "_blank";
							  newLink2.text = surveyid;
							  newTdRow3.append(newLink2);
							} else{
							  surveyid = "0";
							  newTdRow3.append(document.createTextNode("Not Found"));
							}
			 				
		        	    	newTrRow.addEventListener("dblclick", function () {
				            	redirectToNewPage(pid,pname,surveyid);
				            });
			 				
			 				var Tpid = document.createTextNode(pid);
			 				var Tcreateby = document.createTextNode(createby);
			 				var Tmanageby = document.createTextNode(manageby);
			 				var Tcollaborator = document.createTextNode(collaborator);
			 				var date = new Date(createdate);
							Y = date.getFullYear() + '-';
							M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
							D = date.getDate() + ' ';
							var transferdate = Y+M+D;
							var Tdescription = document.createTextNode(description);
			 				var newLink = document.createElement("a");
							newLink.href = "subjectlist?pid=" + pid + "&pname=" + pname + "&surveyid=" + surveyid;
							newLink.text = pname;

							newTdRow1.append(Tpid);
			 				newTdRow2.append(newLink);
			 				newTdRow4.append(Tdescription);
			 				newTdRow5.append(Tmanageby);
			 				newTdRow6.append(Tcollaborator);
			 				newTdRow7.append(Tcreateby);
			 				newTdRow8.append(transferdate);
			 				
			 				newTrRow.append(newTdRow1);
			 				newTrRow.append(newTdRow2);
			 				newTrRow.append(newTdRow3);
			 				newTrRow.append(newTdRow4);
			 				newTrRow.append(newTdRow5);
			 				newTrRow.append(newTdRow6);
			 				newTrRow.append(newTdRow7);
			 				newTrRow.append(newTdRow8);
							
							$("tbody#showprojectlist").append(newTrRow);
		        	      }
		        	    });
			        })(dataList[i].pname, dataList[i].pid, dataList[i].createby, dataList[i].manageby, dataList[i].collaborator, dataList[i].createdate, dataList[i].description); 
	 			}
			}
		}
	});
});
</script>
</body>
</html>    