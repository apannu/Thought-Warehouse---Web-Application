
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>ITMD 565 Lab 3</title>
	<style type="text/css">
		body 
		{
			background-color: #ddd;
			font-family: sans-serif;
		}
		#main-container 
		{
			width: 100%;
			background-color: orange;
			margin:0 auto;
			text-align: center;
			padding: 10px;
		}
		#main1 
		{
			width: 90%;
			background-image:url(./images/header_bg.jpg) no-repeat center top;
			margin:0 auto;
			text-align: center;
			padding: 10px;
		}
		#main1 h2 
		{
			margin-bottom: 5px;
		}
		#employeeList h2 
		{
			margin-bottom: 20px;
		}
		#data-wrapper #button-wrapper button 
		{
			margin: 20px 0;
			font-size: 20px;
		    border-radius: 6px;
		    moz-border-radius: 4px;
		    webkit-border-radius: 4px;
		    height: 30px;
		    width: 110px; 
		    border:1.5px solid;
		}
		.table-style
		{
			 text-align: center;
			 margin-left:auto; 
   			 margin-right:auto;
   			 border:1px solid black;
   			 border-collapse:collapse;
		}
		h1, h2, h3
		{
			font-weight: normal;
		}
		td, th 
		{
 		    border: 1px solid;
		    text-align: left;
		    padding: 10px;
		}
		td
		{
			width: 100px;
		}
		th
		{
			width: 100px;
		}
		tr:nth-child(even) 
		{
			background: #FFF
		}
		tr:nth-child(odd) 
		{
			background: #E5E4E2
		}
		th
		{
    		background: #C0C0C0
		}
		.true
		{
			background-color: #000;
		}
	</style>
</head>
<body>
	<div id="main1">
		<h1>ITMD 565 - Lab 3</h1>
		<h2>Anirudh Pannu - apannu@hawk.iit.edu</h2>
		<div id="data-wrapper">
			<div id="button-wrapper">
				<button id="loadData">Load Data</button>
				<button id="reset">Reset</button>
			</div>
			<div id="employeeList"><h2>Employee List</h2></div>
			<div id="dataGrid"></div>
		</div>
	</div>

	<script type="text/javascript">

		document.getElementById('reset').disabled = true;
		document.getElementById('loadData').disabled = false;
		
		loadHeader();
		
		document.getElementById("reset").addEventListener("click", function () {
			
			document.getElementById('loadData').disabled = false;
			document.getElementById('reset').disabled = true;
			document.getElementById('dataGrid').innerHTML = "";
			
			loadHeader();
			
        });

		document.getElementById("loadData").addEventListener("click",function () {
			
			document.getElementById('dataGrid').innerHTML = "";
			loadData();
		});
		
		function loadHeader()
		{
			var table = document.createElement('table');
			
			var idTh = document.createElement('th');
	        var firstNameTh = document.createElement('th');
	        var lastNameTh = document.createElement('th');
	        var titleTh = document.createElement('th');
	        var emailTh = document.createElement('th');
	        var genderTh = document.createElement('th');
	        var activeTh = document.createElement('th');

	        idTh.innerHTML = "ID";
			firstNameTh.innerHTML = "First Name";
			lastNameTh.innerHTML = "Last Name";
			titleTh.innerHTML = "Title";
			emailTh.innerHTML = "Email";
			genderTh.innerHTML = "Gender";
			activeTh.innerHTML = "Active";
	        
	        var trHeader = document.createElement('tr');
	        
	        trHeader.appendChild(idTh);
	        trHeader.appendChild(firstNameTh);
	        trHeader.appendChild(lastNameTh);
	        trHeader.appendChild(titleTh);
	        trHeader.appendChild(emailTh);
	        trHeader.appendChild(genderTh);
	        trHeader.appendChild(activeTh);
	        
			table.appendChild(trHeader);
			
			table.classList.add('table-style');
	        document.getElementById("dataGrid").appendChild(table);
		}
		
		function loadData()
		{
			var table = document.createElement('table');
			
			var idTh = document.createElement('th');
	        var firstNameTh = document.createElement('th');
	        var lastNameTh = document.createElement('th');
	        var titleTh = document.createElement('th');
	        var emailTh = document.createElement('th');
	        var genderTh = document.createElement('th');
	        var activeTh = document.createElement('th');

	        idTh.innerHTML = "ID";
			firstNameTh.innerHTML = "First Name";
			lastNameTh.innerHTML = "Last Name";
			titleTh.innerHTML = "Title";
			emailTh.innerHTML = "Email";
			genderTh.innerHTML = "Gender";
			activeTh.innerHTML = "Active";
	        
	        var trHeader = document.createElement('tr');
	        
	        trHeader.appendChild(idTh);
	        trHeader.appendChild(firstNameTh);
	        trHeader.appendChild(lastNameTh);
	        trHeader.appendChild(titleTh);
	        trHeader.appendChild(emailTh);
	        trHeader.appendChild(genderTh);
	        trHeader.appendChild(activeTh);
	        
			table.appendChild(trHeader);
			
            var data_file = "http://libertyville.rice.iit.edu/scripts/4565_lab3.php";
            var http_request = new XMLHttpRequest();
            try
            {
               http_request = new XMLHttpRequest();
            }
            catch (e)
            {
               try
               {
                  http_request = new ActiveXObject("Msxml2.XMLHTTP");
               }
               catch (e) 
               {
                  try
                  {
                     http_request = new ActiveXObject("Microsoft.XMLHTTP");
                  }
                  catch (e)
                  {
                     alert("There is something wrong with your code.");
                     return false;
                  }
               }
            }
			
            http_request.onreadystatechange = function(){
			
               if (http_request.readyState == 4  ){
            	   
                  var jsonObj = JSON.parse(http_request.responseText);
                  
                  for (var i = 0; i < jsonObj.length; i++){
                	  
                      var tr = document.createElement('tr');

                      var idTd = document.createElement('td');
                      var firstNameTd = document.createElement('td');
                      var lastNameTd = document.createElement('td');
                      var titleTd = document.createElement('td');
                      var emailTd = document.createElement('td');
                      var genderTd = document.createElement('td');
                      var activeTd = document.createElement('td');

                      idTd.appendChild(document.createTextNode(jsonObj[i].id));
                      firstNameTd.appendChild(document.createTextNode(jsonObj[i].first_name));
                      lastNameTd.appendChild(document.createTextNode(jsonObj[i].last_name));
                      titleTd.appendChild(document.createTextNode(jsonObj[i].title));
                      emailTd.appendChild(document.createTextNode(jsonObj[i].email));
                      genderTd.appendChild(document.createTextNode(jsonObj[i].gender));
                      activeTd.appendChild(document.createTextNode(jsonObj[i].active));
                      
                      tr.appendChild(idTd);
                      tr.appendChild(firstNameTd);
                      tr.appendChild(lastNameTd);
                      tr.appendChild(titleTd);
                      tr.appendChild(emailTd);
                      tr.appendChild(genderTd);
                      tr.appendChild(activeTd);
                      
                      if(JSON.stringify(jsonObj[i].active)=="true")
                    	  activeTd.style.backgroundColor = "#00934a";
                      else
                    	  activeTd.style.backgroundColor = "#FF0000";

                      table.appendChild(tr);
                  }
                  table.classList.add('table-style');
                  document.getElementById("dataGrid").appendChild(table);
                  document.getElementById('reset').disabled = false;
                  document.getElementById('loadData').disabled = true;
               }
            }
			
            http_request.open("GET", data_file, true);
            http_request.send();
         }

	</script>
</body>
</html>