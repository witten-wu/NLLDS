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
					<th>Survey</th>
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
	var paramPairs = value.split('&');
	var paramObj = {};
	paramPairs.forEach(function(pair) {
	  var pairSplit = pair.split('=');
	  var paramName = decodeURIComponent(pairSplit[0]);
	  var paramValue = decodeURIComponent(pairSplit[1]);
	  paramObj[paramName] = paramValue;
	});
	var pid = paramObj.pid;
	var pname = paramObj.pname;
	var surveyid = paramObj.surveyid;
	
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
	 				(function (subjectid, subjectno) {
	 					$.ajax({
			        	      url: "./showSubjectSurvey",
			        	      type: "POST",
			        	      dataType: "json",
			        	      data: {"surveyid": surveyid, "subjectno": subjectno},
			        	      success: function(response) {
			        	    	var newTrRow = document.createElement("tr");
			  	 				var newTdRow1 = document.createElement("td");
			  	 				var newTdRow2 = document.createElement("td");
			  	 				var newTdRow3 = document.createElement("td");
			  	 				var newTdRow4 = document.createElement("td");
			  	 				
				 				var Tsubjectno = document.createTextNode(subjectno);
			  	 				
				 				if (response.code == 1) {
								  // assume only 1 record return and return "id"
								  var id = response.data;
								  var newLink = document.createElement("a");
								  newLink.href = "/limesurvey/index.php?r=responses/view&surveyId=" + surveyid + "&id=" + id;
								  newLink.target = "_blank";
								  newLink.text = "detail...";
								  newTdRow2.append(newLink);
								} else{
								  newTdRow2.append(document.createTextNode("Not Found"));
								}
				 				
								var newLink2 = document.createElement("a");
								newLink2.href = "subjectask?projectid="+pid+"&subjectid="+subjectid;
								newLink2.text = "detail...";
				 				
				 				var viewButton = document.createElement("button");
				 				viewButton.innerText = "view";
				 				viewButton.addEventListener("click", function() {
								    jumpToFtp(pname, subjectno);
								});

				 				
				 				newTdRow1.append(Tsubjectno);
				 				newTdRow3.append(newLink2);
				 				newTdRow4.append(viewButton);
				 				
				 				newTrRow.append(newTdRow1);
				 				newTrRow.append(newTdRow2);
				 				newTrRow.append(newTdRow3);
				 				newTrRow.append(newTdRow4);
				 				
				 				$("tbody#showsubjectlist").append(newTrRow);
			        	      }
			        	    });
	 				})(dataList[i].subjectid, dataList[i].subjectno); 
	 			}
			}
		}
	});
});
	
	function sendRequest(url, command) {
	  const headers = { 'Content-Type': 'application/json' };
	  return fetch(url + '?' + command, { headers })
	    .then(response => response.json())
	    .then(data => {
	      console.log(data);
	    })
	    .catch(error => {
	      console.error(error);
	    });
	}
	
	async function jumpToFtp(pname, subjectno) {
		// generate encrypted file path for localfile system
		const url = '/elFinder/php/connector.minimal.php';
		
		// encrypt project path
		const encodedProjectPath = btoa(pname);
		const replacedProjectPath = encodedProjectPath.replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '.');
		const projectPath = replacedProjectPath.replace(/\.*$/, '');
		
		// encrypt final path
		const tmpath = pname + '/' + subjectno;
		const encodedSubjectPath = btoa(tmpath);
		const replacedSubjectPath = encodedSubjectPath.replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '.');
		const subjectPath = replacedSubjectPath.replace(/\.*$/, '');
		
		let command = '';
		
		try {
			// Need to config l1 in new environment
			// create project folder
			command = "cmd=mkdir&target=l1_Lw" + "&name=" + pname;
			await sendRequest(url, command);
	    	
			// create project/subject folder	
	    	command = "cmd=mkdir&target=l1_" + projectPath + "&name=" + subjectno;
	    	await sendRequest(url, command);
	    	
	    	// create project/subject/Neuroimaging folder
	    	command = "cmd=mkdir&target=l1_" + subjectPath + "&name=Neuroimaging";
	    	await sendRequest(url, command); 
	    	
	    	// create project/subject/Behavior folder
	    	command = "cmd=mkdir&target=l1_" + subjectPath + "&name=Behavior";
	    	await sendRequest(url, command); 
	    	
	    	// create project/subject/Neuroimaging/tasks folder
	    	// create project/subject/Behavior/tasks folder
	    	
	    	// jump to subject folder
	    	window.open("/elFinder/elfinder.html#elf_l1_" + subjectPath);
		} catch (error) {
		    console.error(error);
		  }
    }
</script>
</body>
</html>    