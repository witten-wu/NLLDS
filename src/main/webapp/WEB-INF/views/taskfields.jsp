<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>TaskFields</title>
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
    width: 300px;
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
<div class="container">
  <jsp:include page="sidebar.jsp" />
  <div class="row clearfix">
	<div class="col-md-10">
	    <div id="inputFields" style="margin-bottom: 10px;">
            <div class="input-container">
                <label for="fieldname">Field Name:</label>
                <input type="text" id="fieldname" name="fieldname">
                <span id="newFieldNameError" style="color: red;"></span>
            </div>

            <div class="input-container">
                <label for="remark">Remark:</label>
                <input type="text" id="remark" name="remark">
            </div>
            <button id="addField" style="margin-bottom: 10px;">Add</button>
        </div>
        
	  	<table class="table" style="margin-bottom: 10px;">
			<thead>
				<tr>
					<th>Field_Name</th>
					<th>Remark</th>
				</tr>
			</thead>
			<tbody id="showfields">
			</tbody>
	    </table>
	</div>
  </div>
</div>
<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var value = window.location.search.substr(1);
	var paramPairs = value.split('&');
	var paramObj = {};
	paramPairs.forEach(function(pair) {
	  var pairSplit = pair.split('=');
	  var paramName = decodeURIComponent(pairSplit[0]);
	  var paramValue = decodeURIComponent(pairSplit[1]);
	  paramObj[paramName] = paramValue;
	});
	var taskid = paramObj.tid;
	var tablename = paramObj.table;
	
	
	var newFieldNameInput = document.getElementById('fieldname');
    var newFieldNameError = document.getElementById('newFieldNameError');
    var addFieldButton = document.getElementById('addField');

    newFieldNameInput.addEventListener('input', function() {
        var value = newFieldNameInput.value;
        var isValid = /^[a-zA-Z][a-zA-Z0-9_]{0,63}$/.test(value);
        if (!isValid) {
            newFieldNameError.textContent = 'Please enter a valid Field Name';
            addFieldButton.disabled = true;
        } else {
            newFieldNameError.textContent = '';
            addFieldButton.disabled = false;
        }
    });
		
    $("#addField").click(function() {
        saveField();
    });
    
    function saveField() {
        var fieldname = $("#fieldname").val();
		var remark = $("#remark").val();
		if(fieldname == ""){
			alert("Please input Field Name")
		}
		else{
			$.ajax({ 
				url:"./addField",
				type:"POST", 
				datatype:"json",
				data:{"fieldname":fieldname,"remark":remark,"taskid":taskid},	 
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
						$.ajax({ 
							url:"./addColumn",
							type:"POST", 
							datatype:"json",
							data:{"tablename":tablename,"fieldname":fieldname},	
							success:function(){
								$("#fieldname").val("");
						        $("#remark").val("");        
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
				for(var i=0;i<dataList.length;i++){
					var newTrRow = document.createElement("tr");
	 				var newTdRow1 = document.createElement("td");
	 				var newTdRow2 = document.createElement("td");

	 				var fieldname = document.createTextNode(dataList[i].fieldname);
	 				var remark = document.createTextNode(dataList[i].remark);

	 				newTdRow1.append(fieldname);
	 				newTdRow2.append(remark);
	 				newTrRow.append(newTdRow1);
	 				newTrRow.append(newTdRow2);

	 				$("tbody#showfields").append(newTrRow);
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