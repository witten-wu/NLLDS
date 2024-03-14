<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Subject</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<jsp:include page="sidebar.jsp" />
<div class="container">
	<div class="row clearfix">
		<div class="col-md-10">
			<button id=addSubjectButton style="margin-bottom: 10px;">Add Subject</button>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
                <div class="input-container">
                    <label for="newSubject">Subject No. :</label>
                    <input type="text" id="newSubject" name="newSubject">
                    <span id="newSubjectError" style="color: red;"></span>
                </div>
                <div class="input-container">
                    <span id="subjectDescription" style="margin-right: 10px; font-size: 14px; color: #888;">subject No. Format: Project-HK/GZ-No-Date. For example, NGL-HK-001-20240101</span>
                </div>
                <button id="saveSubjectButton" style="margin-bottom: 10px;">Save</button>
            </div>
           <table class="table" style="margin-bottom: 10px;">
			<thead>
				<tr>
					<th>Subject_No</th>
					<th>Questionnaire</th>
					<th>Tasks</th>
					<th>File</th>
				</tr>
			</thead>
			<tbody id="showsubjectlist">
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
	
	var value = window.location.search.substr(1);
	var pid = value.split('=')[1];
	
	var newSubjectInput = document.getElementById('newSubject');
    var newSubjectError = document.getElementById('newSubjectError');
    var saveSubjectButton = document.getElementById('saveSubjectButton');

    newSubjectInput.addEventListener('input', function() {
        var value = newSubjectInput.value;
        if (/[\u4e00-\u9fa5]/.test(value)) {
            newSubjectError.textContent = 'Please enter a valid Subject No.';
            saveSubjectButton.disabled = true;
        } else {
            newSubjectError.textContent = '';
            saveSubjectButton.disabled = false;
        }
    });
	
	$(document).ready(function(){
	$("#addSubjectButton").click(function() {
        $("#inputFields").toggleClass("hidden");
    });
    
    $("#saveSubjectButton").click(function() {
        saveNewSubject();
    });
    
    $("tbody#showsubjectlist").on("click", "tr", function() {
   	  $("tbody#showsubjectlist tr").removeClass("selected-row");
   	  $(this).addClass("selected-row");
   	});
    
    function saveNewSubject() {
        var subjectno = $("#newSubject").val();
		var projectid = pid;
        if(subjectno == ""){
			alert("Please input subject No.")
		}else{
	        $.ajax({ 
				url:"./addSubject",
				type:"POST", 
				datatype:"json",
				data:{"subjectno":subjectno,"projectid":projectid},	 
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
					}else if(data.code==0){
						alert(data.msg)
					}
				}
			})

	        $("#newSubject").val("");
	        $("#inputFields").addClass("hidden");
	        
	        location.reload();
        }
    }

	$.ajax({ 
		url:"./showSubjectList",
		type:"POST", 
		datatype:"json",
		data:{"pid":pid},	 
		async:"false",
		success:function(data){
			var str =""; 
			data = JSON.parse(data); 
			dataList = data.data; 
			if(data.code==1){
				for(var i=0;i<dataList.length;i++){
					var newTrRow = document.createElement("tr");
	 				//var newTdRow1 = document.createElement("td");
	 				var newTdRow2 = document.createElement("td");
	 				var newTdRow3 = document.createElement("td");
	 				var newTdRow4 = document.createElement("td");
	 				var newTdRow5 = document.createElement("td");
	 				
	 				var subjectid = document.createTextNode(dataList[i].subjectid);
	 				var subjectno = document.createTextNode(dataList[i].subjectno);
	 				var projectid = pid;
	 				
	 				var newLink = document.createElement("a");
					newLink.href = "subjectquestionnaire?projectid="+projectid+"&subjectno="+dataList[i].subjectno;
					newLink.text = "detail..."
					
					var newLink2 = document.createElement("a");
					newLink2.href = "subjectask?projectid="+projectid+"&subjectid="+dataList[i].subjectid;
					newLink2.text = "detail...";
	 				
	 				var viewButton = document.createElement("button");
	 				viewButton.innerText = "view";
	 				
	 				viewButton.addEventListener("click", function() {
					    loginToFilestash();
					});
	 				
	 				//newTdRow1.append(subjectid);
	 				newTdRow2.append(subjectno);
	 				newTdRow3.append(newLink);
	 				newTdRow4.append(newLink2);
	 				newTdRow5.append(viewButton);
	 				
	 				//newTrRow.append(newTdRow1);
	 				newTrRow.append(newTdRow2);
	 				newTrRow.append(newTdRow3);
	 				newTrRow.append(newTdRow4);
	 				newTrRow.append(newTdRow5);
	 				
	 				$("tbody#showsubjectlist").append(newTrRow);
	 			}
			}
		}
	});
});

	function loginToFilestash() {
    	window.open("http://192.168.1.107:8334/files/home/")
    }
</script>
</body>
</html>    