<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
  <head>
  <style>
  	.tooltip-inner {
   width: 350px;
}
 .imageupload {
                margin: 20px 0;
            }
  </</style>
    <meta charset="utf-8">
    <title>Thought Warehouse</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    
    <!-- Facebook Opengraph integration: https://developers.facebook.com/docs/sharing/opengraph -->
    <meta property="og:title" content="">
    <meta property="og:image" content="">
    <meta property="og:url" content="">
    <meta property="og:site_name" content="">
    <meta property="og:description" content="">
    
    <!-- Twitter Cards integration: https://dev.twitter.com/cards/  -->
    <meta name="twitter:card" content="summary">
    <meta name="twitter:site" content="">
    <meta name="twitter:title" content="">
    <meta name="twitter:description" content="">
    <meta name="twitter:image" content="">

    <!-- Fav and touch icons -->
    <link rel="shortcut icon" href="img/icons/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/icons/114x114.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/icons/72x72.png">
    <link rel="apple-touch-icon-precomposed" href="img/icons/default.png">
  
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900" rel="stylesheet">
    
    <!-- Bootstrap CSS File -->
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
    <!-- Libraries CSS Files -->
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/lib/owlcarousel/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/lib/owlcarousel/owl.theme.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/lib/owlcarousel/owl.transitions.min.css" rel="stylesheet">
    
    <!-- Main Stylesheet File -->
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/css/style.css" rel="stylesheet">
    
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/css/bootstrap-imageupload.css" rel="stylesheet">
    
<!-- 		<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/> -->
  		<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-course/new1/lib/bootstrap/css/bootstrapValidator.min.css"/>
  		
<%--   		<script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/jquery/jquery.min.js"></script> --%>
			<script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/bootstrap/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script>
		
		 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
    
	    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/jquery/jquery.min.js"></script>
	    
		<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
	    
	    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/bootstrap/js/bootstrap.min.js"></script>
	    
	    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/js/bootstrap-imageupload.js"></script>

	<style>
	.overlay {
    opacity: 0.3;
}

ul.ui-autocomplete.ui-menu{width:520px}
.ui-menu-item{border-bottom: 2px solid #e9e9e9; text-decoration:none;}

.ui-autocomplete 
{
    max-height: 400px;
    overflow-y: auto;
    overflow-x: hidden;
}
 .ui-corner-all {
    -moz-border-radius: 0;
    -webkit-border-radius: 0;
    border-radius: 0;
}
.ui-menu {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 14px;
    text-decoration: none;
}
.ui-menu .ui-menu-item a {
	text-decoration:none;
    color: #888;
}
.ui-menu .ui-menu-item:hover {
    display: block;
     color: white;
    cursor: pointer;
    background-color: lightgray;
    background-image: none;
border: 1px solid lightgray;
}
.ui-widget-content .ui-state-hover, .ui-widget-content .ui-state-focus {
border: 1px solid lightgray;
    background-image: none;
     background-color: lightgray;
    text-decoration: none;
    font-weight: bold;
    color: white;
}
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-state-active.ui-button:hover 
{
 border: 0px solid #000;
  background: lightgray;
  text-decoration: none;
}
a, u{
	text-decoration: none;
}
	</style>
    <script>
    
    <%
 // response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
 // response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
 // response.setDateHeader("Expires", -1); // Proxies.
 	String username = "";
 	String username1 = "";
 	HttpSession httpSession = request.getSession(false);
 	username = (String) httpSession.getAttribute("username");
 	if(username==null||username.equals(""))
 		username1 = "no";
 	else
 		username1 = username;
 %>

 	var username = '<%=username%>';
 	var username1 = '<%=username1%>';
 	console.log(username);
 	console.log(username1);
 	
 	function submitSignUpForm()
 	{
 		if(!validateForm())
 		{
 			document.getElementById("registerForm").submit();
 		}
 	}
 	
 	function validateForm()
 	{
 		$("#registerStatusDiv").css({
	 		  display: "none",
	 		});
 		
		var usernameFlg = false;
		var passwordFlg = false;
		var confirmPasswordFlg = false;
		var matchPasswordFlg = false;
		var firstNameFlg = false;
		var lastNameFlg = false;
		var emailIdFlg = false;
		var contactFlg = false;
		var companyFlg = false;
		var professionFlg = false;
		var educationFlg = false;
		
		//empty all the validation divs
		document.getElementById("validationUsername").innerHTML = "";
		document.getElementById("validationPassword").innerHTML = "";
		document.getElementById("validationConfirmPassword").innerHTML = "";
		document.getElementById("validationMatchPassword").innerHTML = "";
		document.getElementById("validationFirstName").innerHTML = "";
		document.getElementById("validationLastName").innerHTML = "";
		document.getElementById("validationEmailId").innerHTML = "";
		document.getElementById("validationContact").innerHTML = "";
		document.getElementById("validationCompany").innerHTML = "";
		document.getElementById("validationProfession").innerHTML = "";
		document.getElementById("validationEducation").innerHTML = "";

		//define variables to get the field values
		var usernameValue = document.getElementById("username").value;
		var passwordValue = document.getElementById("password").value;
		var confirmPasswordValue = document.getElementById("confirmPassword").value;
		var firstNameValue = document.getElementById("firstName").value;
		var lastNameValue = document.getElementById("lastName").value;
		var emailIdValue = document.getElementById("emailId").value;
		var contactValue = document.getElementById("contact").value;
		var companyValue = document.getElementById("company").value;
		var professionValue = document.getElementById("profession").value;
		var educationValue = document.getElementById("education").value;
		
		//code for username validation
		if(usernameValue.length == 0){
			
			document.getElementById("validationUsername").innerHTML = "<li>Please enter a username.</li>";
			$("#username").prop('required',true);
			usernameFlg = true;
		}
		else if(!usernameValue.length == 0)
		{
			if (!usernameValue.match(/^[a-zA-Z0-9]+$/))
			{
				document.getElementById("validationUsername").innerHTML += "<li>Please enter the username in a correct format.</li>";
				usernameFlg = true;
			}
			if(usernameValue.length < 5 || usernameValue.length > 8 )
			{
				document.getElementById("validationUsername").innerHTML += "<li>Username must contain at least 5 and at most 8 characters.</li>";
				usernameFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationUsername").innerHTML = "";
			usernameFlg = false;
		}
		
		console.log("1 "+usernameFlg);		
		
		//code for password validation
		if(passwordValue.length == 0){
			
			document.getElementById("validationPassword").innerHTML = "<li>Please enter a password.</li>";
			$("#password").prop('required',true);
			passwordFlg = true;
		}
		else if(!passwordValue.length == 0)
		{
			if (!passwordValue.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/))
			{
				document.getElementById("validationPassword").innerHTML += "<li>Please enter the password in a correct format.</li>";
				passwordFlg = true;
			}
			if(passwordValue.length < 8)
			{
				document.getElementById("validationPassword").innerHTML += "<li>Password must contain at least 8 characters.</li>";
				passwordFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationPassword").innerHTML = "";
			passwordFlg = false;
		}
		
		console.log("2 "+passwordFlg);
		
		//code for confirm password validation
		if(confirmPasswordValue.length == 0){
			
			document.getElementById("validationConfirmPassword").innerHTML = "<li>Please enter a password.</li>";
			$("#confirmPassword").prop('required',true);
			confirmPasswordFlg = true;
		}
		else if(!confirmPasswordValue.length == 0)
		{
			if (!confirmPasswordValue.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/))
			{
				document.getElementById("validationConfirmPassword").innerHTML += "<li>Please enter the password in correct format.</li>";
				confirmPasswordFlg = true;
			}
			if(confirmPasswordValue.length < 8)
			{
				document.getElementById("validationConfirmPassword").innerHTML += "<li>Password must contain at least 8 characters.</li>";
				confirmPasswordFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationConfirmPassword").innerHTML = "";
			confirmPasswordFlg = false;
		}
		
		console.log("3 "+confirmPasswordFlg);
		
		//code to match the password validation
		if($('#confirmPassword').val()!=$('#password').val()){
			
			document.getElementById("validationMatchPassword").innerHTML = "<li>Your passwords do not match. Please try again.</li>";
			matchPasswordFlg = true;
		}
		else
		{
			
			document.getElementById("validationMatchPassword").innerHTML = "";
			matchPasswordFlg = false;
		}
		
		console.log("4 "+matchPasswordFlg);
		
		//code for first name validation
		if(firstNameValue.length == 0){
			
			document.getElementById("validationFirstName").innerHTML = "<li>Please enter a first name.</li>";
			$("#firstName").prop('required',true);
			firstNameFlg = true;
		}
		else if(!firstNameValue.length == 0)
		{
			if (!firstNameValue.match(/^[a-zA-Z]+$/))
			{
				document.getElementById("validationFirstName").innerHTML += "<li>Please enter the first name in a correct format.</li>";
				firstNameFlg = true;
			}
			if(firstNameValue.length > 30)
			{
				document.getElementById("validationFirstName").innerHTML += "<li>First name must contain at most 30 characters.</li>";
				firstNameFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationFirstName").innerHTML = "";
			firstNameFlg = false;
		}
		
		console.log("5 "+firstNameFlg);
		
		//code for last name validation
		if(lastNameValue.length == 0){
			
			document.getElementById("validationLastName").innerHTML = "<li>Please enter a last name.</li>";
			$("#lastName").prop('required',true);
			lastNameFlg = true;
		}
		else if(!lastNameValue.length == 0)
		{
			if (!lastNameValue.match(/^[a-zA-Z]+$/))
			{
				document.getElementById("validationLastName").innerHTML += "<li>Please enter the last name in a correct format.</li>";
				lastNameFlg = true;
			}
			if(lastNameValue.length > 30)
			{
				document.getElementById("validationLastName").innerHTML += "<li>Last name must contain at most 30 characters.</li>";
				lastNameFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationLastName").innerHTML = "";
			lastNameFlg = false;
		}
		
		console.log("6 "+lastNameFlg);
		
		//code for email validation
		if(emailIdValue.length == 0){
			
			document.getElementById("validationEmailId").innerHTML = "<li>Please enter an email id.</li>";
			$("#emailId").prop('required',true);
			emailIdFlg = true;
		}
		else if(!emailIdValue.length == 0)
		{
			if (!emailIdValue.match(/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,7}$/))
			{
				document.getElementById("validationEmailId").innerHTML += "<li>Please enter the email id in a correct format.</li>";
				emailIdFlg = true;
			}
			if(emailIdValue.length > 23)
			{
				document.getElementById("validationEmailId").innerHTML += "<li>Email Id can contain at most 23 characters.</li>";
				emailIdFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationEmailId").innerHTML = "";
			emailIdFlg = false;
		}
		
		console.log("7 "+emailIdFlg);
		
		//code for contact validation
		if(contactValue.length == 0){
			
			document.getElementById("validationContact").innerHTML = "<li>Please enter a contact.</li>";
			$("#contact").prop('required',true);
			contactFlg = true;
		}
		else if(!contactValue.length == 0)
		{
// 			if (!contactValue.match(/^\+?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/))
			if(!contactValue.match(/[0-9]{2}\d{8}/))
			{
				document.getElementById("validationContact").innerHTML += "<li>Please enter the contact number in a correct format.</li>";
				contactFlg = true;
			}
			if(contactValue.length > 11)
			{
				document.getElementById("validationContact").innerHTML += "<li>Contact must contain at most 11 characters.</li>";
				contactFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationContact").innerHTML = "";
			contactFlg = false;
		}
		
		console.log("8 "+contactFlg);
		
		//code for company validation
		if(companyValue.length == 0){
			
			document.getElementById("validationCompany").innerHTML = "<li>Please enter your company details.</li>";
			$("#company").prop('required',true);
			companyFlg = true;
		}
		else if(!companyValue.length == 0)
		{
			if (!companyValue.match(/^[a-zA-Z .,&-()]+$/))
			{
				document.getElementById("validationCompany").innerHTML += "<li>Please enter the company details in a correct format.</li>";
				companyFlg = true;
			}
			if(companyValue.length > 39)
			{
				document.getElementById("validationCompany").innerHTML += "<li>Company details must contain at most 40 characters.</li>";
				companyFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationCompany").innerHTML = "";
			companyFlg = false;
		}
		
		console.log("9 "+companyFlg);
		
		//code for profession validation
		if(professionValue.length == 0){
			
			document.getElementById("validationProfession").innerHTML = "<li>Please enter your profession.</li>";
			$("#profession").prop('required',true);
			professionFlg = true;
		}
		else if(!professionValue.length == 0)
		{
			if (!professionValue.match(/^[a-zA-Z .,&-()]+$/))
			{
				document.getElementById("validationProfession").innerHTML += "<li>Please enter the profession details in a correct format.</li>";
				professionFlg = true;
			}
			if(professionValue.length > 39)
			{
				document.getElementById("validationProfession").innerHTML += "<li>Profession details must contain at most 40 characters.</li>";
				professionFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationProfession").innerHTML = "";
			professionFlg = false;
		}
		
		console.log("10 "+professionFlg);
		
		//code for education validation
		if(educationValue.length == 0){
			
			document.getElementById("validationEducation").innerHTML = "<li>Please enter your education details.</li>";
			$("#education").prop('required',true);
			educationFlg = true;
		}
		else if(!educationValue.length == 0)
		{
			if (!educationValue.match(/^[a-zA-Z .,&-()]+$/))
			{
				document.getElementById("validationEducation").innerHTML += "<li>Please enter the education details in a correct format.</li>";
				educationFlg = true;
			}
			if(educationValue.length > 39)
			{
				document.getElementById("validationEducation").innerHTML += "<li>Education details must contain at most 40 characters.</li>";
				educationFlg = true;
			}
		}
		else
		{
			
			document.getElementById("validationEducation").innerHTML = "";
			educationFlg = false;
		}
		console.log("11 "+educationFlg);
		if(usernameFlg || passwordFlg || confirmPasswordFlg || firstNameFlg || matchPasswordFlg || lastNameFlg || emailIdFlg || contactFlg || companyFlg || professionFlg || educationFlg){
			   return true;
		   }else{
			   return false;
		   }
 	}
 	
 	
 	
 	function monkeyPatchAutocomplete() {

 		$.ui.autocomplete.prototype._renderItem = function (ul, item) {
	            item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(this.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), 
	            		"<span style='font-weight:bold;color:orange'>" + 
	                    "$&" + 
	                    "</span>");
	            return $("<li></li>")
	                    .data("item.autocomplete", item)
	                    .append("<a href='javascript:submitSearchForm()'>" + item.label + "</a>")
	                    .appendTo(ul);
        };
 	}
 	
 	function submitSearchForm()
 	{
 		var value = document.getElementById("searchData").value;
 		if(value.length==0)
 			{}
 		else if(value.length!=0)
 		{
 			document.getElementById("searchForm").action = "search";
 			document.getElementById("searchForm").submit();
 		}
 	}
 
 $(document).ready(function(){
	 
	//manage the search box code
   	 $("#searchButton").click(function(){
   			submitSearchForm();
   	    }); 
   	 
   	 $("#searchData").keydown(function(event) {
   		    if(event.keyCode == 13) {
   		      submitSearchForm();
   		    }
   		});
   	 
   	 monkeyPatchAutocomplete();
   	 
   	 $( "#searchData" ).autocomplete({
   			source: '${pageContext.request.contextPath}/getAutoSuggest'
   		});
   	 
   	 $('#searchData').click(function(e){
   		 document.getElementById('content').classList.add('overlay');
   		});

   		$('#content').click(function(e){
   			document.getElementById('content').classList.remove('overlay');
   		});
   		
   		
 	    $('[data-toggle="tooltip"]').tooltip();   
 	   $("#registerStatusDiv").css({
	 		  display: "none",
	 		});
 	   
 	  var temp = '${registerStatus}';
		if(temp!="")
 		{
 			console.log(temp);
			$("#registerStatusDiv").show();
			$("#registerStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#registerStatusDiv").slideUp(500);
	     }); 
 		 	$(".alert").alert();
 		}
 	});
 	
  </script>
    
  </head>
  
  <body class="page-index has-hero">
    <!--Change the background class to alter background image, options are: benches, boots, buildings, city, metro -->
    <div id="background-wrapper" class="buildings" data-stellar-background-ratio="0.1">
	      
	      <!-- ======== @Region: #navigation ======== -->
      <div id="navigation" class="wrapper">
        <!--Header & navbar-branding region-->
        <div class="header">
          <div class="header-inner container">
            <div class="row">
              <div class="col-md-8">
                <div class="navbar-slogan">
                  <h4 style="font-weight: bold">Thought Warehouse</h4>
                </div>
              </div>
              <div class="col-md-4">
                <!--user menu-->
                <ul class="list-inline user-menu pull-right">
                  <li id = "login" class="hidden-xs"><i class="fa fa-sign-in text-primary"></i> <a href="${pageContext.request.contextPath}/login" class="text-uppercase">Login</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="navbar navbar-default">
            <!--mobile collapse menu button-->
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse" aria-expanded="false"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
            <!--everything within this div is collapsed on mobile-->
            <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav" id="main-menu">
                <li class="icon-link">
                  <a href="${pageContext.request.contextPath}/show"><i class="fa fa-home"></i></a>
                </li>
              </ul>
              <ul>
	              <form:form id="searchForm" name ="searchForm" method="post" role="form" modelAttribute="topQuestions">
		              <div class="col-sm-3 col-md-3">
			        	  <form class="navbar-form" role="search">
				              <div class="input-group">
					              <input type="text" class="form-control" placeholder="Search Question, Answer or Blog" id = "searchData" name="searchData" style="width:520px; margin-top:14px">
					              <div class="input-group-btn">
					              		<button id = "searchButton" class="btn btn-default" type="submit" style="margin-top:14px"><i class="glyphicon glyphicon-search"></i></button>
					              </div>
				        	  </div>
			        	  </form>
		    		  </div>
		    	</form:form>
    		</ul>
            </div>
            <!--/.navbar-collapse -->
          </div>
        </div>
      </div>
    </div>
    
    <!-- ======== @Region: #content ======== -->
    <div id="content">
      <!-- Mission Statement -->
      <div class="mission text-center block block-pd-sm block-bg-noise">
        <div class="container">
          <h2 class="text-shadow-white">
          Thought Warehouse is a discussion portal. We provide an interface where users can post their questions and provide appropriate solutions. 
<!--             <a href="about.html" class="btn btn-more"><i class="fa fa-plus"></i>Read more</a> -->
          </h2>
        </div>
      </div>
      
      <!--Customer testimonial & Latest Blog posts-->
      <div class="testimonials block-contained">
        <div id="main-content" class="row">
          <!--Customer testimonial-->
          <div id="login-content" class="col-md-6 m-b-lg">
          <div class="alert alert-danger" id="registerStatusDiv">
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${registerStatus}
		    </div>
            <h3 class="block-title">
              Please enter your details
            </h3>
             <div class="form" id="register-content">
              <form:form id="registerForm" action = "register" name ="registerForm" data-toggle="validator" method="post" role="form" modelAttribute="loginForm" enctype="multipart/form-data">
        		  <div class="form-group">
				  	  <div class="imageupload panel panel-default">
			                <div class="panel-heading clearfix">
			                    <h3 class="panel-title pull-left">Upload Profile Picture</h3>
			                    <div class="btn-group pull-right">
			                    </div>
			                </div>
			                <div class="file-tab panel-body">
			                    <label class="btn btn-default btn-file">
			                        <span>Browse</span>
			                        <input type="file" id="profilePic" name="profilePic">
			                    </label>
			                    <button type="button" class="btn btn-default">Remove</button>
			                </div>
			           </div>
				  </div>

                  <div class="form-group">
                  	<label class="control-label" for="username">Username</label>
                  	<input type="text" class="form-control" name="username" id="username" placeholder="Username" data-toggle="tooltip" data-placement="right" 
                  	title="Username must contain only alphabets and numbers. For eg. anpannu, anpannu567"/>
                    <div id="validationUsername" style="color:#A52A2A"></div>
                  </div>
                  <div class="form-group">
                  <label class="control-label" for="password">Password</label>
                    <input type="password" class="form-control" name="password" id="password" placeholder="Password" data-toggle="tooltip" data-placement="right" 
                  	title="Password must contain one letter, one number, one unique character such as !@#$%^&? and be at least 8 characters long. For eg. SQL36oracle$$$, pannu78#"/>
                    <div id="validationPassword" style="color:#A52A2A"></div>
                  </div>
                    <div class="form-group">
                    <label class="control-label" for="confirmPassword">Confirm Password</label>
                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" data-toggle="tooltip" data-placement="right" 
                  	title="Must match exactly with the above password"/>
                  	<div id="validationConfirmPassword" style="color:#A52A2A"></div>
                  	<div id="validationMatchPassword" style="color:#A52A2A"></div>
                  </div>
                  <div class="form-group">
                  	<label class="control-label" for="firstName">First Name</label>
                    <input type="text" class="form-control" name="firstName" id="firstName" placeholder="First Name" data-toggle="tooltip" data-placement="right" 
                  	title="First name must contain only alphabets. For eg. Anirudh, Yash"/>
                  	<div id="validationFirstName" style="color:#A52A2A"></div>
                  </div>
                    <div class="form-group">
                    <label class="control-label" for="lastName">Last Name</label>
                    <input type="text" class="form-control" name="lastName" id="lastName" placeholder="Last Name" data-toggle="tooltip" data-placement="right" 
                  	title="Last name must contain only alphabets. For eg. Pannu, Reed"/>
                    <div id="validationLastName" style="color:#A52A2A"></div>
                  </div>
                  <div class="form-group">
                  <label class="control-label" for="emailId">Email Id</label>
                    <input type="email" class="form-control" name="emailId" id="emailId" placeholder="Email Id" data-toggle="tooltip" data-placement="right" 
                  	title="Email Id must contain @ character, alphabets and numbers. For eg. apannu@hawk.iit.edu, pannuanirudh@gmail.com"/>
                    <div id="validationEmailId" style="color:#A52A2A"></div>
                  </div>
                      <div class="form-group">
                      <label class="control-label" for="contact">Contact</label>
                    <input type="text" class="form-control" name="contact" id="contact" placeholder="Contact" data-toggle="tooltip" data-placement="right" 
                  	title="Contact must be alphanumeric. For eg. 3128667564, 9897191138"/>
                    <div id="validationContact" style="color:#A52A2A"></div>
                  </div>
                  <div class="form-group">
                     <label class="control-label" for="company">Company</label>
                    <input type="text" class="form-control" name="company" id="company" placeholder="Company" data-toggle="tooltip" data-placement="right" 
                  	title="Company can contain a (.), (,), (&) and (-) characters. For eg. Capgemini - India, Capgemini"/>
                    <div id="validationCompany" style="color:#A52A2A"></div>
                  </div>
                  <div class="form-group">
                  	<label class="control-label" for="profession">Profession</label>
                    <textarea class="form-control" name="profession" id="profession" rows="2" placeholder="Profession" data-toggle="tooltip" data-placement="right" 
                  	title="Profession can contain a (.), (,), (&) and (-) characters. For eg. Senior Software Engineer: Consultant, Lead Developer & Manager"></textarea>
                    <div id="validationProfession" style="color:#A52A2A"></div>
                  </div>
                   <div class="form-group">
                   <label class="control-label" for="education">Education</label>
                    <textarea class="form-control" name="education" id="education" rows="2" placeholder="Education" data-toggle="tooltip" data-placement="right" 
                  	title="Education can contain a (.), (,), (&) and (-) characters. For eg. Master of Science: Information Technology - Software Developement, Bachelor of Science & Master of Sciencce"></textarea>
                    <div id="validationEducation" style="color:#A52A2A"></div>
                  </div>
                  <div><button type="button" class="btn" onClick="submitSignUpForm()">Register</button></div>
              </form:form>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- ======== @Region: #footer ======== -->
    <footer id="footer" class="block block-bg-grey-dark" data-block-bg-img="${pageContext.request.contextPath}/bootstrap-course/new1/img/bg_footer-map.png" data-stellar-background-ratio="0.4">
      <div class="container">
        
        <div class="row" id="contact">
          
          <div class="col-md-3">
            <address>
              <strong>Thought Warehouse</strong>
              <br>
              <i class="fa fa-map-pin fa-fw text-primary"></i> 3300 S Federal St
              <br>
              <i class="fa fa-phone fa-fw text-primary"></i> 312-567-3000
              <br>
              <i class="fa fa-envelope-o fa-fw text-primary"></i> apannu@hawk.iit.com
              <br>
            </address>
          </div>
          
          <div class="col-md-6">
            <h4 class="text-uppercase">
              Contact Us
            </h4>
            <div class="form">
              <div id="sendmessage">Your message has been sent. Thank you!</div>
              <div id="errormessage"></div>
              <form action="" method="post" role="form" class="contactForm">
                  <div class="form-group">
                    <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
                    <div class="validation"></div>
                  </div>
                  <div class="form-group">
                    <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" data-rule="email" data-msg="Please enter a valid email" />
                    <div class="validation"></div>
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control" name="subject" id="subject" placeholder="Subject" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />
                    <div class="validation"></div>
                  </div>
                  <div class="form-group">
                    <textarea class="form-control" name="message" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="Message"></textarea>
                    <div class="validation"></div>
                  </div>
                  <div class="text-center"><button type="submit">Send Message</button></div>
              </form>
            </div>
          </div>
          
          <div class="col-md-3">
            <h4 class="text-uppercase">
              Follow Us On:
            </h4>
            <!--social media icons-->
            <div class="social-media social-media-stacked">
              <!--@todo: replace with company social media details-->
              <a href="#"><i class="fa fa-twitter fa-fw"></i> Twitter</a>
              <a href="#"><i class="fa fa-facebook fa-fw"></i> Facebook</a>
              <a href="#"><i class="fa fa-linkedin fa-fw"></i> LinkedIn</a>
              <a href="#"><i class="fa fa-google-plus fa-fw"></i> Google+</a>
            </div>
          </div>
          
        </div>
        
        <div class="row subfooter">
          <!--@todo: replace with company copyright details-->
          <div class="col-md-7">
            <p>Copyright © Thought Warehouse</p>
            <div class="credits">
            </div>
          </div>
          <div class="col-md-5">
            <ul class="list-inline pull-right">
              <li><a href="#">Terms</a></li>
              <li><a href="#">Privacy</a></li>
              <li><a href="#">Contact Us</a></li>
            </ul>
          </div>
        </div>
        
        <a href="#top" class="scrolltop">Top</a> 
        
      </div>
    </footer>
    
    <!-- Required JavaScript Libraries -->
<%--     <script src="${pageContext.request.contextPath}/bootstrap-course/new1/js/bootstrap-imageupload.js"></script> --%>
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/stellar/stellar.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/counterup/counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/contactform/contactform.js"></script>
    <!-- Template Specisifc Custom Javascript File -->
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/js/custom.js"></script>
    
    <!--Custom scripts demo background & colour switcher - OPTIONAL -->
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/js/color-switcher.js"></script>
    
    <!--Contactform script -->
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/contactform/contactform.js"></script>
    <script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-55234356-4', 'auto');
      ga('send', 'pageview');
    </script>
    
    <script>var $imageupload = $('.imageupload');
    $imageupload.imageupload();</script>
    
  </body>
</html>