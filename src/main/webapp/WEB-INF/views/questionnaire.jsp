<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Questionnaire</title>
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
<div class="container">
	<jsp:include page="sidebar.jsp" />
	<div class="row clearfix">
	 	
		<div class="col-md-10">
			<button id=addQusButton style="margin-bottom: 10px;">Add/Update Questionnaire</button>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
	                <div class="input-container">
	                    <label for="newPId">Project ID:</label>
	                    <input type="text" id="newPId" name="newPId">
	                </div>

	                <div class="input-container">
	                    <label for="QusUrl">Questionnaire Ref.:</label>
	                    <input type="text" id="QusUrl" name="QusUrl">
	                </div>
	                <button id="saveQusButton" style="margin-bottom: 10px;">Save</button>
	            </div>
           <table class="table" style="margin-bottom: 10px;">
			<thead>
				<tr>
					<th>Project_ID</th>
					<th>Project_Name</th>
					<th>Questionnaire</th>
				</tr>
			</thead>
			<tbody id="showquslist">
			</tbody>
		   </table>
        </div>
	</div>
</div>
<script src="bootstrap/js/jquery-3.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$("#addQusButton").click(function() {
	    $("#inputFields").toggleClass("hidden");
	});
	
	$("#saveQusButton").click(function() {
	    saveQus();
	});
	
	$("tbody#showquslist").on("click", "tr", function() {
   	  $("tbody#showquslist tr").removeClass("selected-row");
   	  $(this).addClass("selected-row");
   	});
	
	function saveQus() {
	    var pid = $("#newPId").val();
	    var questionnaire = $("#QusUrl").val();
	    if(pid == ""){
			alert("Please input the Project ID")
		}else if(questionnaire == ""){
			alert("Please input the Questionnaire url")
		}else{
	        $.ajax({ 
				url:"./addQuestionnaire",
				type:"POST", 
				datatype:"json",
				data:{"pid":pid,"questionnaire":questionnaire},	 
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
					}else if(data.code==0){
						alert(data.msg)
					}
				}
			})
	
	        $("#newPId").val("");
	        $("#QusUrl").val("");
	        $("#inputFields").addClass("hidden");
	        
	        location.reload();
	    }
	}
	
	
	function viewquestionnaire(pid) {
		window.location.href = "projectquestionnaire?projectid=" + pid;
    }
	
	$.ajax({ 
		url:"./showProjectQus",
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

	 				var pid = document.createTextNode(dataList[i].pid);
	 				var pname = document.createTextNode(dataList[i].pname);
	 				var viewButton = document.createElement("button");
	 				viewButton.innerText = "view";
	 				viewButton.setAttribute("data-projectid", dataList[i].pid);
	 				viewButton.addEventListener("click", function() {
	 					var pid = this.getAttribute("data-projectid");
					    viewquestionnaire(pid);
					});
					
	 				newTdRow1.append(pid);
	 				newTdRow2.append(pname);
	 				newTdRow3.append(viewButton);
	 				
	 				newTrRow.append(newTdRow1);
	 				newTrRow.append(newTdRow2);
	 				newTrRow.append(newTdRow3);
	 				
	 				$("tbody#showquslist").append(newTrRow);
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