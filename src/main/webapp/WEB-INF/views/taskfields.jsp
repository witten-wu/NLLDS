<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>TaskFields</title>
<link rel="stylesheet" type="text/css" href="bootstrap/css/style.css">
</head>
<body>
<jsp:include page="sidebar.jsp" />
<div class="container">
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
    
    $("tbody#showfields").on("click", "tr", function() {
   	  $("tbody#showfields tr").removeClass("selected-row");
   	  $(this).addClass("selected-row");
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
    
    function showContextMenu(x, y, id, fieldname) {
       var menu = document.createElement("ul");
       menu.className = "context-menu";
       menu.innerHTML = "<li>delete</li>";
       menu.querySelector("li").addEventListener("click", function () {
         deleteTaskField(id, fieldname); 
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

    function deleteTaskField(id, fieldname) {
    	$.ajax({ 
    		url:"./checkTaskField",
    		type:"POST", 
    		datatype:"json",	 
    		data:{"tablename":tablename, "fieldname":fieldname},	
    		success:function(data){
    			data = JSON.parse(data); 
    			dataList = data.data; 
    			if(data.code==1){
    				$.ajax({ 
    		    		url:"./deleteFields",
    		    		type:"POST", 
    		    		datatype:"json",	 
    		    		data:{"id":id},	
    		    		async:"false",
    		    		success:function(data){
    		    			data = JSON.parse(data); 
    		    			dataList = data.data; 
    		    			if(data.code==1){
    		    				location.reload();
    		    				$.ajax({ 
    		    		    		url:"./deleteColumn",
    		    		    		type:"POST", 
    		    		    		datatype:"json",	 
    		    		    		data:{"tablename":tablename, "fieldname":fieldname},	
    		    		    		success:function(data){
    		    		    		}
    		    		    	});
    		    				
    		    			}else if(data.code==0){
    		    				alert(data.msg)
    		    			}
    		    		}
    		    	});
    			}else if(data.code==0){
    				alert(data.msg)
    			}
    		}
    	});
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
					
			        (function (id, fieldname) {
			        	newTrRow.addEventListener("contextmenu", function (e) {
				          e.preventDefault();
				          showContextMenu(e.clientX, e.clientY, id, fieldname);
				          $("tbody#showfields tr").removeClass("selected-row");
				          this.classList.add("selected-row");
				        });
			        })(dataList[i].id, dataList[i].fieldname); 
					
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
			}
		}
	});
});
</script>
</body>
</html>