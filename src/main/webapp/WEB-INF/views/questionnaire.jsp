<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Questionnaire</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<%int Grade = ((User)session.getAttribute("user")).getGrade();%>
<jsp:include page="sidebar.jsp" />
<div class="container">
	<div class="row clearfix">
		<div class="col-md-10">
			<button id=addQusButton style="margin-bottom: 10px;">Add/Update Questionnaire</button>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
	                <div class="input-container">
	                    <label for="newPId">Project ID:</label>
	                    <select id="newPId" name="newPId"> 
					    	<option value="">Please Select</option>
					    </select>
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
	    var pid = $("#newPId option:selected").val();
	    var questionnaire = $("#QusUrl").val();
	    if(pid == ""){
			alert("Please select the Project ID")
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
						$("#newPId").val("");
				        $("#QusUrl").val("");
				        $("#inputFields").addClass("hidden");
				        location.reload();
					}else if(data.code==0){
						alert(data.msg);
					}
				}
			})
	    }
	}
	
	
	function viewquestionnaire(pid) {
		window.open("projectquestionnaire?projectid=" + pid);
    }
	
	
	$.ajax({
		url:"./showProjectID",
		type:"POST", 
		datatype:"json",
		data:{"username":Username, "grade":Grade},
		async:"false",
		success:function(data){
			data = JSON.parse(data); 
			dataList = data.data; 
			for(var i=0;i < dataList.length;i++){
				var newRow = document.createElement("option");
				var pid = document.createTextNode(dataList[i].pid);
				newRow.append(pid);
				newRow.value=dataList[i].pid;
				$("#newPId").append(newRow);
			}
		}
	});
	
	
	$.ajax({ 
		url:"./showProjectQus",
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
			}
		}
	});
});

</script>
</body>
</html>    