
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<!-- Modify Title between these comments (Choose correct class number and substitute your username) -->
	<title>ITMD 565 Lab 2 - apannu - DOM Manipulation</title>
	<!-- Modify Title between these comments -->
	<style type="text/css">
		body {
			background-color: #ccc;
			font-family: sans-serif;
		}
		label {
			width: 100px;
			display: inline-block;
			margin: 5px 0;
		}
		input {
			display: inline-block;
			margin: 5px 0;
		}
		button {
			display: inline-block;
			margin: 20px 10px 20px 0;
		}
		#wrapper {
			background-color: #fff;
			max-width: 800px;
			margin: 0 auto;
			padding: 20px 40px;
		}
		#resultsWrapper .result {
			border: 4px solid red;
			padding: 10px;
			margin: 10px 0;
		}
		#resultsWrapper .red {
			border-color: red;
		}
		#resultsWrapper .red h2 {
			color: red;
		}
		#resultsWrapper .green {
			border-color: green;
		}
		#resultsWrapper .green h2 {
			color: green;
		}
		#resultsWrapper .blue {
			border-color: blue;
		}
		#resultsWrapper .blue h2 {
			color: blue;
		}
		/* You may add additional CSS below this comment if you feel necessary */
		
	</style>
</head>
<body>
	<div id="wrapper">
		<!-- Modify headlines between these comments (Choose correct class number and substitute Name and Email) -->
		<h1>ITMD 565 - Lab 2 - DOM Manipulation</h1>
		<h2>Anirudh Pannu - apannu@hawk.iit.edu</h2>
		<!-- Modify headlines between these comments -->
		<label for="bodyInput">Body Text: </label><input id="bodyInput" type="text"><br>
		<label for="qtyInput">Quantity: </label><input id="qtyInput" type="text"><br>
		<label for="colorInput">Color: </label>
		<select id="colorInput">
			<option value="red">Red</option>
			<option value="green">Green</option>
			<option value="blue">Blue</option>
		</select><br>
		
		<button id="runBtn">Run Lab</button>
		<button id="resetBtn">Reset Lab</button>
		
		<h2>Results</h2>
		<div id="resultsWrapper"></div>
	</div>
	
	<script type="text/javascript">
	
		document.getElementById('resetBtn').disabled = true;
		
		// Begin JavaScript Code Here - Do not put JavaScript outside these comments.
		 document.getElementById("runBtn").addEventListener("click",function () {
			 document.getElementById('resultsWrapper').innerHTML = "";
				var output = document.getElementById('resultsWrapper');
				var incrementalVariable = 1;
				if(validateInputs(document.getElementById('qtyInput').value))
				{
					while(incrementalVariable<=Number(document.getElementById('qtyInput').value))
				    {
				            var newDiv = document.createElement("div");
				            newDiv.setAttribute("id","div"+incrementalVariable);
	
							var h2Tag = document.createElement("h2");
				            var h2TagTextNode = document.createTextNode("Output "+incrementalVariable);
				            h2Tag.appendChild(h2TagTextNode);
				            
				            var pTag = document.createElement("p");
				            var pTagTextNode = document.createTextNode(document.getElementById('bodyInput').value);
				            pTag.appendChild(pTagTextNode);
				            
				            if(document.getElementById('colorInput').value == 'red')
				            {
				            	console.log("red");
				            	newDiv.classList.add('red','result');
				            }
				            else if(document.getElementById('colorInput').value == 'green')
				            {
				            	console.log("green");
				            	newDiv.classList.add('green','result');
				            	
				            }
				            else if(document.getElementById('colorInput').value == 'blue')
				            {
				            	console.log("blue");
				            	newDiv.classList.add('blue','result');
				            }
				            
				            newDiv.appendChild(h2Tag);
				            newDiv.appendChild(pTag);
				            output.appendChild(newDiv);
				            incrementalVariable++;
				    }
					document.getElementById('bodyInput').value = '';
					document.getElementById('qtyInput').value = '';
					document.getElementById('resetBtn').disabled = false;
				}
		 });
		
		 document.getElementById("resetBtn").addEventListener("click",function () {
			 document.getElementById('bodyInput').value = '';
			 document.getElementById('qtyInput').value = '';
			 document.getElementById('resultsWrapper').innerHTML = "";
			 document.getElementById('resetBtn').disabled = true;
	 });
		 
		 var qauntityNumber = document.getElementById('qtyInput').value;
		 
		 function validateInputs(qauntityNumber) {
			 
			 
			 
			 if(isNaN(qauntityNumber)){
					alert("Please try again with a valid quantity number.");
					document.getElementById('resetBtn').disabled = true;
					document.getElementById('bodyInput').value = '';
					 document.getElementById('qtyInput').value = '';
					return false;
				}
			 
			 else if(document.getElementById('bodyInput').value == ""){
					alert("Please enter the body text.");
					document.getElementById('resetBtn').disabled = true;
					document.getElementById('bodyInput').value = '';
					 document.getElementById('qtyInput').value = '';
					return false;
				}
	        	
	        	else if(qauntityNumber == ""){
					alert("Quantity number cannot be empty. Please try again.");
					document.getElementById('resetBtn').disabled = true;
					document.getElementById('bodyInput').value = '';
					 document.getElementById('qtyInput').value = '';
					return false;
				}
	        	
	        	else if(Number(qauntityNumber) < 1)
	        	{
	        		alert("Quantity number cannot be less than 1. Please try again.");
	        		document.getElementById('resetBtn').disabled = true;
	        		document.getElementById('bodyInput').value = '';
	   			 document.getElementById('qtyInput').value = '';
					return false;
	        	}

	            else
	                return true;
	        }

		// End JavaScript Code Here - Do not put JavaScript outside these comments.
	</script>
</body>
</html>