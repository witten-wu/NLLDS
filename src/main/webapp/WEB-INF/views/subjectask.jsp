<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Task Data</title>
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
  
  #fieldsContainer input[type="text"] {
    width: 150px;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 12px;
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
  
  #fieldsContainer {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 10px;
}

.field-label {
	width: 170px;
    display: inline-block;
    margin-right: 10px;
    margin-bottom: 10px;
    font-size: 12px;
    overflow: hidden; 
    text-overflow: ellipsis;
}
</style>
<body>
<div class="container">
	<jsp:include page="sidebar.jsp" />
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
				for(var i=0;i < dataList.length;i++){
					var newRow = document.createElement("option");
					var tname = document.createTextNode(dataList[i].tname);
					newRow.append(tname);
					newRow.value=dataList[i].tid;
					$("#showTaskList").append(newRow);
				}
			}
		});
		
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
				  var tasks = dataList[i].tasks.split(",");
			      for (var j = 0; j < tasks.length; j++) {
			      	(function (currentTask) {
			    	    var processedTask = currentTask.replace("_template", "");
				        $.ajax({
							url:"./showSubjectTasks",
							type:"POST", 
							datatype:"json",
							data: {"subjectid": subjectid, "tablename": tasks[j]},
							async:"false",
							success:function(data){
								data = JSON.parse(data);
								dataList = data.data; 
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
						});
			    	 })(tasks[j]);
			      }
				}
			}
		});
	});
</script>
</body>
</html>