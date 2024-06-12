<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Task Data</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<jsp:include page="sidebar.jsp" />
<div class="container">
	<div class="row clearfix">
		<div class="col-md-10">
		    <h2>Add Task Data</h2>
		    <select class="form-control" id="showTaskList" onchange="selectOnchang(this)" style="margin-bottom: 10px;"> 
		    	<option value="">Select a template</option>
		    </select>
		    <div id="fieldsContainer" style="margin-bottom: 10px;"></div>
		    <button id="saveButton" class="hidden">Save Data</button>
		    <h2>Added Task Data</h2>
		    <div id="tableContainer"></div>
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
	
	var value = window.location.search.substr(1);
	var paramPairs = value.split('&');
	var paramObj = {};
	paramPairs.forEach(function(pair) {
	  var pairSplit = pair.split('=');
	  var paramName = decodeURIComponent(pairSplit[0]);
	  var paramValue = decodeURIComponent(pairSplit[1]);
	  paramObj[paramName] = paramValue;
	});
	var projectid = paramObj.projectid;
	var subjectid = paramObj.subjectid;

    var taskData = [];
    
	function selectOnchang(){
	    var taskselect = $('#showTaskList option:selected').val();
        if (taskselect) {
           loadTemplateFields(taskselect);
           document.getElementById('saveButton').classList.remove('hidden');
        } else {
           clearFieldsContainer();
           document.getElementById('saveButton').classList.add('hidden');
        }
	};

    function loadTemplateFields(taskid) {
        clearFieldsContainer();
		$.ajax({
			url:"./showFields",
			type:"POST", 
			datatype:"json",
			data:{"taskid":taskid},		 
			async:"false",
			success:function(data){
				data = JSON.parse(data); 
				dataList = data.data; 
				if(data.code==1){
					var fieldsContainer = document.getElementById('fieldsContainer');
			        for (var i = 0; i < dataList.length; i++) {
			            var label = document.createElement('label');
			            label.textContent = dataList[i].fieldname + ':';
			            var input = document.createElement('input');
			            input.type = 'text';
			            input.name = dataList[i].fieldname;
			            label.appendChild(input);
			            label.classList.add('field-label');
			            fieldsContainer.appendChild(label);
			        }
				}else{
    				alert(data.msg);
    				location.reload();
    			}
			}
		}); 
    }

    function clearFieldsContainer() {
        var fieldsContainer = document.getElementById('fieldsContainer');
        while (fieldsContainer.firstChild) {
            fieldsContainer.firstChild.remove();
        }
    }
	
    $("#saveButton").click(function() {
    	var taskid = $('#showTaskList option:selected').val();
    	var tablename = $('#showTaskList option:selected').text() + '_template';
        var formData = getFormData();
        $.ajax({ 
			url:"./insertField",
			type:"POST", 
			data: {"tablename": tablename, "formData": JSON.stringify(formData)},
			success:function(data){
				$.ajax({ 
					url:"./updateSubjecttasks",
					type:"POST", 
					data: {"tablename": tablename, "subjectid": subjectid, "projectid": projectid},
					success:function(data){
						location.reload();
					}
				})
			}
		})
    });
    
    function getFormData() {
        var formData = {};
        var fieldsContainer = document.getElementById('fieldsContainer');
        var inputs = fieldsContainer.getElementsByTagName('input');
        for (var i = 0; i < inputs.length; i++) {
            var input = inputs[i];
            formData[input.name] = input.value;
        }
        formData["projectid"] = projectid;
        formData["subjectid"] = subjectid;
        return formData;
    }

	$(document).ready(function(){
		$.ajax({
			url:"./showTaskList",
			type:"POST", 
			datatype:"json",	 
			async:"false",
			success:function(data){
				data = JSON.parse(data); 
				dataList = data.data; 
				if(data.code==1){
					for(var i=0;i < dataList.length;i++){
						var newRow = document.createElement("option");
						var tname = document.createTextNode(dataList[i].tname);
						newRow.append(tname);
						newRow.value=dataList[i].tid;
						$("#showTaskList").append(newRow);
					}
				}
			}
		});
		
		function showContextMenu(x, y, id, tablename) {
	       var menu = document.createElement("ul");
	       menu.className = "context-menu";
	       menu.innerHTML = "<li>Delete</li>";
	       menu.querySelector("li").addEventListener("click", function () {
	         deleteSubjectTask(id, tablename); 
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
		
		function deleteSubjectTask(id, tablename) {
	    	$.ajax({ 
	    		url:"./deleteSubjectTasks",
	    		type:"POST", 
	    		datatype:"json",	 
	    		data:{"id":id, "tablename":tablename},	
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
		
		 function setRowClickListener() {
			var div = document.getElementById("tableContainer");
			var tbodies = div.getElementsByTagName("tbody");
			var rows = [];
			for (var i = 0; i < tbodies.length; i++) {
			    var tbodyRows = tbodies[i].getElementsByTagName("tr");
			    for (var j = 0; j < tbodyRows.length; j++) {
			        rows.push(tbodyRows[j]);
			    }
			}
			for (var i = 0; i < rows.length; i++) {
			    rows[i].addEventListener("click", function() {
			        for (var j = 0; j < rows.length; j++) {
			            rows[j].classList.remove("selected-row");
			        }
			        this.classList.add("selected-row");
			    });
			}
	    }
		
		$.ajax({
			url:"./getSubjectTasks",
			type:"POST", 
			datatype:"json",
			data: {"subjectid": subjectid},
			async:"false",
			success:function(data){
				data = JSON.parse(data); 
				dataList = data.data; 
				for(var i=0;i < dataList.length;i++){
				  if (dataList[i].tasks != null) {
					  var tasks = dataList[i].tasks.split(",");
					  var taskCount = tasks.length;
	                  var completedTasks = 0;
				      for (var j = 0; j < tasks.length; j++) {
				      	(function (currentTask) {
				    	    var processedTask = currentTask.replace("_template", "");
					        $.ajax({
								url:"./showSubjectTasks",
								type:"POST", 
								datatype:"json",
								data: {"subjectid": subjectid, "tablename": currentTask},
								async:"false",
								success:function(data){
									data = JSON.parse(data);
									dataList = data.data; 
									if(data.code==1){
										var tableContainer = document.getElementById("tableContainer");
								        var table = document.createElement("table");
								        table.classList.add("table");
								        var thead = document.createElement("thead");
								        var headerRow = document.createElement("tr");
								        var keys = Object.keys(dataList[0]);
							            var th = document.createElement("th");
							            th.textContent = "Task";
							            headerRow.appendChild(th);
								        keys.forEach(function(key) {
								        	if (key !== "id" && key !== "projectid" && key !== "subjectid") {
									            var th = document.createElement("th");
									            th.textContent = key;
									            headerRow.appendChild(th);
								        	}
								        });
								        thead.appendChild(headerRow);
								        table.appendChild(thead);
								        var tbody = document.createElement("tbody");
								        dataList.forEach(function(rowData) {
								            var row = document.createElement("tr");
								            
								            (function (id, tablename) {
								            	row.addEventListener("contextmenu", function (e) {
										          e.preventDefault();
										          showContextMenu(e.clientX, e.clientY, id, tablename);
										          $("div#tableContainer tr").removeClass("selected-row");
										          this.classList.add("selected-row");
										        });
									        })(rowData["id"], currentTask); 
								            
								            var tablenameCell = document.createElement("td");
								            tablenameCell.textContent = processedTask;
								            row.appendChild(tablenameCell);
								            keys.forEach(function(key) {
								            	if (key !== "id" && key !== "projectid" && key !== "subjectid") {
									                var cell = document.createElement("td");
									                cell.textContent = rowData[key];
									                row.appendChild(cell);
								            	}
								            });
								            tbody.appendChild(row);
								        });
								        table.appendChild(tbody);
								        tableContainer.appendChild(table);								        
									}
									completedTasks = completedTasks + 1;
                                    if (completedTasks === taskCount) {
                                        setRowClickListener();
                                    }
								}
							});
				    	 })(tasks[j]);
				      } 
				  }
				}
			}
		});
	});
</script>
</body>
</html>