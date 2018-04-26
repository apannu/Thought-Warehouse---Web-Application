
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<!-- Modify Title between these comments (Choose correct class number and substitute your username) -->
	<title>ITMD 565 Lab 1 - apannu - Simple Calculator</title>
	<!-- Modify Title between these comments -->
	<style type="text/css">
		body {
			background-color: #ddd;
			font-family: sans-serif;
		}
		#main-container {
			width: 100%;
			
			background-color: orange;
			margin:0 auto;
			text-align: center;
			padding: 10px;
		}
		#main1 {
		width: 100%;
	background-image:url(./images/header_bg.jpg) no-repeat center top;
	margin:0 auto;
			text-align: center;
			padding: 10px;
}
		#calculator-wrapper #input-wrapper {
			margin: 40px 0 20px;
		}
		#calculator-wrapper #input-wrapper label {
			font-size: 18px;
			margin: 0 4px;
			font-style: italic;
		}
		#calculator-wrapper #input-wrapper input {
			font-size: 20px;
			padding: 4px;
			border: 2px solid #bbb;
			background-color: #eee;
		}
		#calculator-wrapper #button-wrapper {
			margin: 20px 0;
		}
		#calculator-wrapper #button-wrapper button {
			font-size: 20px;
			margin: 0 5px;
		}
		#results {
			margin: 20px;
			background-color: #eee;
			border: 2px solid #bbb;
			font-size: 24px;
			padding: 14px;
			overflow-x: auto;
			min-height: 25px;
		}
	</style>
</head>
<body>
	<div id="main1">
		<!-- Modify headlines between these comments (Choose correct class number and substitute Name and Email) -->
		<h1>ITMD 565 - Lab 1 - Simple Calculator</h1>
		<h2>Anirudh Pannu - apannu@hawk.iit.edu</h2>
		<!-- Modify headlines between these comments -->
		<div id="calculator-wrapper">
			<div id="input-wrapper">
				<label>Value 1: <input type="text" name="val1" id="val1"></label>
				<label>Value 2: <input type="text" name="val2" id="val2"></label>
			</div>
			<div id="button-wrapper">
				<button id="addBtn">Add</button>
				<button id="subBtn">Subtract</button>
				<button id="multBtn">Multiply</button>
				<button id="divBtn">Divide</button>
				<button id="resetBtn">Reset</button>
			</div>
			<div id="results"></div>
		</div>
		<img src="images/header_bg.jpg" alt="Smiley face" height="80" width="80">
	</div>

	<script type="text/javascript">
		// Begin JavaScript Code Here - Do not put JavaScript outside these comments.

		document.getElementById("resetBtn").addEventListener("click", function () {
            document.getElementById("val1").value = "";
            document.getElementById("val2").value = "";

            document.getElementById("results").innerHTML = "";
        });

		document.getElementById("subBtn").addEventListener("click",function () {
			var number1 = document.getElementById("val1").value;
			var number2 = document.getElementById("val2").value;

			if(checkValues(number1,number2)){
                var substractedValue = Number(number1) - Number(number2);

                document.getElementById("results").innerHTML = substractedValue;
			}
		});

        document.getElementById("multBtn").addEventListener("click",function () {
            var number1 = document.getElementById("val1").value;
            var number2 = document.getElementById("val2").value;

            if(checkValues(number1,number2)){
                var multipliedValue = Number(number1) * Number(number2);

                document.getElementById("results").innerHTML = multipliedValue;
            }
        });

        document.getElementById("divBtn").addEventListener("click",function () {
            var number1 = document.getElementById("val1").value;
            var number2 = document.getElementById("val2").value;

            if(checkValues(number1,number2)){
                if(number2 == 0){
						alert("Number 1 cannot be divided by 0.")
				}
				else{
                	var dividedValue = Number(number1) / Number(number2);
                    document.getElementById("results").innerHTML = dividedValue;
                }

            }
        });


        document.getElementById("addBtn").addEventListener("click",function () {
            var number1 = document.getElementById("val1").value;
            var number2 = document.getElementById("val2").value;

            if(checkValues(number1,number2)){
                var additionValue = Number(number1) + Number(number2);

                document.getElementById("results").innerHTML = additionValue;
            }
        });


        function checkValues(number1, number2) {
        	if(isNaN(number1)){
				alert("Number 1 is not a valid number.");
				return false;
			}

			else if(isNaN(number2)){
                alert("Number 2 is not a valid number.");
                return false;
			}

			else if(number1 == ""){
                alert("Number 1 cannot be empty.");
                return false;
			}

            else if(number2 == ""){
                alert("Number 2 cannot be empty.");
                return false;
            }

            else
                return true;
        }

		// End JavaScript Code Here - Do not put JavaScript outside these comments.
	</script>
</body>
</html>