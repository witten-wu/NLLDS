<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Subject</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<%String Username = ((User)session.getAttribute("user")).getUsername();%>
<%int Grade = ((User)session.getAttribute("user")).getGrade();%>
<%String Region = ((User)session.getAttribute("user")).getRegion();%>
<jsp:include page="sidebar.jsp" />
<div id="Loading-overlay" class="loading-overlay">
	<div id="Loading" class="loader"></div>
</div>
<div class="container">
	<div class="row clearfix" style="width:100%">
		<div class="col-md-10" style="width:100%">
			<button id=addSubjectButton style="margin-bottom: 10px;">Add Subject</button>
			<div id="inputFields" class="hidden" style="margin-bottom: 10px;">
                <div class="input-container">
                    <label for="newSubject">Subject No. :</label>
                    <input type="text" id="newSubject" name="newSubject">
                    <span id="newSubjectError" style="color: red;"></span>
                </div>
                <div class="input-container">
                	<span id="subjectRemark" style="margin-right: 10px; font-size: 14px; color: #f00;">Please use our pre-generated Subject No.<span id="subjectDescription" style="margin-right: 10px; font-size: 14px; color: #888;"> (Subject No. Format: Project_Region_No._Date)</span></span>
                </div>
                <button id="saveSubjectButton" style="margin-bottom: 10px;">Save</button>
            </div>
           <div class="table-container">
	           <table class="table table-bordered table-hover dt-responsive" style="margin-bottom: 10px;">
				<thead style="background-color: #000000; color: white;">
					<tr>
						<th>Subject No</th>
						<th>Survey</th>
						<th>TaskFile</th>
						<th>NeuroFile</th>
					</tr>
				</thead>
				<tbody id="showsubjectlist">
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
		
		if (!$("#inputFields").hasClass("hidden")) {
			var prefix = pname + "_" + "<%=Region%>" + "_";
			 $.ajax({ 
				url:"./CheckSubjectNo",
				type:"POST", 
				datatype:"json",
				data:{"prefix":prefix},	 
				success:function(data){
					data=JSON.parse(data);
					suffix = data.data;
					$("#newSubject").val(prefix + suffix);
				}
			});
		}else{
			$("#newSubject").val("");
		}
		
    });
    
    $("#saveSubjectButton").click(function() {
        saveNewSubject();
    });
    
    $("tbody#showsubjectlist").on("click", "tr", function() {
   	  $("tbody#showsubjectlist tr").removeClass("selected-row");
   	  $(this).addClass("selected-row");
   	});
	
    var Grade = <%=Grade%>;
    var Username = "<%=Username%>"
    
    getAjaxData(pid, Grade, Username, surveyid, pname);
});
	
	async function getAjaxData(pid, Grade, Username, surveyid, pname) {
		$("#Loading-overlay").show();	
		$("#Loading").show();
		
		try {
		  const response1 = await $.ajax({
		    url: "./showSubjectList",
		    type: "POST",
		    datatype: "json",
		    data: { "pid": pid, "grade": Grade, "username": Username }
		  });
		  const data = JSON.parse(response1);
		  const dataList = data.data;
		
		  if (data.code === 1) {
		    for (let i = 0; i < dataList.length; i++) {
		      const { subjectid, subjectno, tasks } = dataList[i];
		      const response2 = await $.ajax({
		        url: "./showSubjectSurvey",
		        type: "POST",
		        dataType: "json",
		        data: { "surveyid": surveyid, "subjectno": subjectno }
		      });
		
		      const newTrRow = document.createElement("tr");
		      const newTdRow1 = document.createElement("td");
		      const newTdRow2 = document.createElement("td");
		      const newTdRow3 = document.createElement("td");
		      const newTdRow4 = document.createElement("td");
		
		      const Tsubjectno = document.createTextNode(subjectno);
		
		      if (response2.code === 1) {
		        const id = response2.data;
		        const newLink = document.createElement("a");
		        newLink.href = "/limesurvey/index.php?r=responses/view&surveyId=" + surveyid + "&id=" + id;
		        newLink.target = "_blank";
		        newLink.text = "detail...";
		        newTdRow2.append(newLink);
		      } else {
		        newTdRow2.append(document.createTextNode("Not Found"));
		      }
		
		      const taskArray = tasks ? tasks.split(",") : [];
		      for (let j = 0; j < taskArray.length; j++) {
		        const tmpLink = document.createElement("a");
		        tmpLink.href = "#";
		        tmpLink.text = taskArray[j];
		        tmpLink.addEventListener("click", function() {
		          event.preventDefault();
		          jumpToFtp(pname, subjectno, "Behavior");
		        });
		        newTdRow3.append(tmpLink);
		        if (j < taskArray.length - 1) {
		          const commaSpan = document.createElement("span");
		          commaSpan.innerText = ", ";
		          newTdRow3.append(commaSpan);
		        }
		      }
		
		      const viewButton = document.createElement("button");
		      viewButton.innerText = "view";
		      viewButton.addEventListener("click", function() {
		        jumpToFtp(pname, subjectno, "Neuroimaging");
		      });
		      viewButton.style.display = "block";
		      viewButton.style.marginLeft  = "0";
		      viewButton.style.marginRight = "auto";
		
		      newTdRow1.append(Tsubjectno);
		      newTdRow4.append(viewButton);
		
		      newTrRow.append(newTdRow1);
		      newTrRow.append(newTdRow2);
		      newTrRow.append(newTdRow3);
		      newTrRow.append(newTdRow4);
		
		      $("tbody#showsubjectlist").append(newTrRow);
		    }
		  }
		} catch (error) {
		  console.error(error);
		}
		$("#Loading").hide();
		$("#Loading-overlay").hide();
	}
	
	function saveNewSubject() {
        var subjectno = $("#newSubject").val();
		var projectid = pid;
		var addby = "<%=Username%>"
        if(subjectno == ""){
			alert("Please input subject No.")
		}else{
	        $.ajax({ 
				url:"./addSubject",
				type:"POST", 
				datatype:"json",
				data:{"subjectno":subjectno,"projectid":projectid,"addby":addby},	 
				success:function(data){
					data=JSON.parse(data);
					if(data.code==1){
						$("#newSubject").val("");
				        $("#inputFields").addClass("hidden");
				        location.reload();
					}else if(data.code==0){
						alert(data.msg);
					}
				}
			})
        }
    }
	
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
	
	async function jumpToFtp(pname, subjectno, target) {
		// generate encrypted file path for localfile system
		const url = '/elFinder/php/connector.minimal.php';
		
		// encrypt project path
		const encodedProjectPath = btoa(pname);
		const replacedProjectPath = encodedProjectPath.replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '.');
		const projectPath = replacedProjectPath.replace(/\.*$/, '');
		
		// encrypt subject path
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
	    	
	    	
	    	// jump to target folder
    		// encrypt target path
    		const targetpath = pname + '/' + subjectno + '/' + target;
    		const encodedtargetpath = btoa(targetpath);
    		const replacedtargetpath = encodedtargetpath.replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '.');
    		const processedtargetpath = replacedtargetpath.replace(/\.*$/, '');
    		window.open("/elFinder/elfinder.html#elf_l1_" + processedtargetpath);
		} catch (error) {
		    console.error(error);
		}
    }
</script>
</body>
</html>    