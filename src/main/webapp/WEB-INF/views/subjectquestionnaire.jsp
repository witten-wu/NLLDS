<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Questionnaire</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<jsp:include page="sidebar.jsp" />	
<div class="container">
	<div id="tableContainer"></div>
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
	var subjectno = paramObj.subjectno;
	
	$(document).ready(function(){
		$.ajax({
			url:"./getSubjectQus",
			type:"POST", 
			datatype:"json",
			data: {"projectid": projectid},
			async:"false",
			success:function(data){
				data = JSON.parse(data); 
				dataList = data.data; 
				var qustable = dataList[0].qustable;
				$.ajax({
					url:"./showSubjectQus",
					type:"POST", 
					datatype:"json",
					data: {"subjectno": subjectno, "tablename": qustable},
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
				            keys.forEach(function(key) {
					            var th = document.createElement("th");
					            th.textContent = key;
					            headerRow.appendChild(th);
					        });
					        thead.appendChild(headerRow);
					        table.appendChild(thead);
					        var tbody = document.createElement("tbody");
					        dataList.forEach(function(rowData) {
					            var row = document.createElement("tr");
					            keys.forEach(function(key) {
					                var cell = document.createElement("td");
					                cell.textContent = rowData[key];
					                row.appendChild(cell);
					            });
					            tbody.appendChild(row);
					        });
					        table.appendChild(tbody);
					        tableContainer.appendChild(table); 
						}
					}
				});
				
			}
		});
		
	});
	
</script>
</body>
</html>    