<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<!--     <link rel="shortcut icon" href="img/icons/favicon.png"> -->
<!--     <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/icons/114x114.png"> -->
<!--     <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/icons/72x72.png"> -->
<!--     <link rel="apple-touch-icon-precomposed" href="img/icons/default.png"> -->
  
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
    
<!--     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<!--     <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script> -->
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
    
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/jquery/jquery.min.js"></script>
    
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
    
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/bootstrap/js/bootstrap.min.js"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script>
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
 	
 $(document).ready(function() {
	 
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
		
 	
 	   $("#registerStatusDiv").css({
	 		  display: "none",
	 		});
 	  $("#loginPostQuestionStatusDiv").css({
 		  display: "none",
 		});
 	  
 	  
 	 $("#loginPostAnswerStatusDiv").css({
		  display: "none",
		});
 	 
 	 $("#loginPostCommentStatusDiv").css({
		  display: "none",
		});
 	   
 	$("#loginPostBlogStatusDiv").css({
		  display: "none",
		});
 	
 	  $("#loginStatusDiv").css({
 		  display: "none",
 		});
 	  
 	  var temp = '${signupStatus}';
 	  var temp1 = '${loginStatus}';
 	  var temp2 = '${loginPostQuestionStatus}';
 	  var temp3 = '${loginPostAnswerStatus}';
 	  var temp4 = '${loginPostCommentStatus}';
 	  var temp5 = '${loginPostBlogStatus}';
 	  
 		if(temp!="")
 		{
 			console.log(temp);
			$("#registerStatusDiv").show();
			$("#registerStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#registerStatusDiv").slideUp(500);
	     }); 
 		 	$(".alert").alert();
 		}
 		if(temp1!="")
 		{
 			console.log(temp);
			$("#loginStatusDiv").show();
			$("#loginStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#loginStatusDiv").slideUp(500);
	     }); 
 		 	$(".alert").alert();
 		}
 		if(temp2!="")
 		{
 			console.log(temp);
			$("#loginPostQuestionStatusDiv").show();
			$("#loginPostQuestionStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#loginPostQuestionStatusDiv").slideUp(500);
	     }); 
 		 	$(".alert").alert();
 		}
 		if(temp3!="")
 		{
 			console.log(temp);
			$("#loginPostAnswerStatusDiv").show();
			$("#loginPostAnswerStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#loginPostAnswerStatusDiv").slideUp(500);
	     }); 
 		 	$(".alert").alert();
 		}
 		if(temp4!="")
 		{
 			console.log(temp);
			$("#loginPostCommentStatusDiv").show();
			$("#loginPostCommentStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#loginPostCommentStatusDiv").slideUp(500);
	     }); 
 		 	$(".alert").alert();
 		}
 		if(temp5!="")
 		{
 			console.log(temp);
			$("#loginPostBlogStatusDiv").show();
			$("#loginPostBlogStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#loginPostBlogStatusDiv").slideUp(500);
	     }); 
 		 	$(".alert").alert();
 		}
 	});
	
	function submitLoginForm()
 	{
 		if(!validateForm())
 		{
 			document.getElementById("loginForm").submit();
 		}
 	}
	
	function validateForm()
 	{
		$("#registerStatusDiv").css({
	 		  display: "none",
	 		});
		
		$("#loginStatusDiv").css({
	 		  display: "none",
	 		});
		
		$("#loginPostQuestionStatusDiv").css({
	 		  display: "none",
	 		});
		
		$("#loginPostAnswerStatusDiv").css({
	 		  display: "none",
	 		});
		
		$("#loginPostCommentStatusDiv").css({
	 		  display: "none",
	 		});
		
		$("#loginPostBlogStatusDiv").css({
	 		  display: "none",
	 		});
		
		var usernameFlg = false;
		var passwordFlg = false;
		
		//empty all the validation divs
		document.getElementById("validationUsername").innerHTML = "";
		document.getElementById("validationPassword").innerHTML = "";

		//define variables to get the field values
		var usernameValue = document.getElementById("username").value;
		var passwordValue = document.getElementById("password").value;
		
		//code for username validation
		if(usernameValue.length == 0){
			
			document.getElementById("validationUsername").innerHTML = "<li>Please enter a username.</li>";
			$("#username").prop('required',true);
			usernameFlg = true;
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
		else
		{
			document.getElementById("validationPassword").innerHTML = "";
			passwordFlg = false;
		}
		
		console.log("2 "+passwordFlg);
		
		if(usernameFlg || passwordFlg){
			   return true;
		   }else{
			   return false;
		   }
 	}
 	
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
                  <li id = "register" class="hidden-xs"><i class="fa fa-edit text-primary"></i> <a href="${pageContext.request.contextPath}/signup" class="text-uppercase">Register</a></li>
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
          <div id = "login-content" class="col-md-6 m-b-lg">
            <h3 class="block-title">
              Please enter your credentials
            </h3>
             <div class="form">
			<div class="alert alert-success" id="registerStatusDiv">
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${signupStatus}
		    </div>
		    <div class="alert alert-info" id="loginPostQuestionStatusDiv">
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${loginPostQuestionStatus}
		    </div>
		    <div class="alert alert-info" id="loginPostAnswerStatusDiv">
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${loginPostAnswerStatus}
		    </div>
		    <div class="alert alert-info" id="loginPostCommentStatusDiv">
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${loginPostCommentStatus}
		    </div>
		     <div class="alert alert-info" id="loginPostBlogStatusDiv">
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${loginPostBlogStatus}
		    </div>
			<div class="alert alert-danger" id="loginStatusDiv">
		    <!-- you missed this line of code -->
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${loginStatus}
		    </div>
              <form:form action="checkLogin" id="loginForm" name="loginForm" method="post" role="form" modelAttribute="login" data-toggle="validator">
                  <div class="form-group">
                    <input type="text" class="form-control" name="username" id="username" placeholder="Username"/>
                    <div id="validationUsername" style="color:#A52A2A"></div>
                  </div>
                  <div class="form-group">
                    <input type="password" class="form-control" name="password" id="password" placeholder="Password"/>
                    <div id="validationPassword" style="color:#A52A2A"></div>
                  </div>
                  <div class="text-center"><button type="button" class="btn" onClick="submitLoginForm()">Login</button></div>
                  <h3>If you are not a member, please click <a href="${pageContext.request.contextPath}/signUp">here</a> to sign up</h3>
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
  
  </body>
</html>