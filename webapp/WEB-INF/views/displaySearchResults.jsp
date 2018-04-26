<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
  <head>
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
    
    <!--Your custom colour override - predefined colours are: colour-blue.css, colour-green.css, colour-lavander.css, orange is default-->
<!--     <link href="#" id="colour-scheme" rel="stylesheet"> -->
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
    
    	.outter{
    padding: 0px;
    border: 1px solid rgba(255, 255, 255, 0.29);
    border-radius: 50%;
    width: 200px;
    height: 200px;
}
.image-circle{
    border-radius: 50%;
/*     width: 175px; */
/*     height: 175px; */
/*  	width: 50px; */
/*     height: 50px; */
	width: 185px;
    height: 185px;
    border: 4px solid #FFF;
    margin: 10px;
}
.image-circleQuestions{
    border-radius: 50%;
  	width: 50px;
     height: 50px;
    border: 4px solid #FFF;
    margin: 10px;
}
.aParent div {
    float: left;
    clear: none; 
}

.labelDivForm div {
    float: left;
    clear: none; 
}

.divLineTop {
    border-top:2px silver solid;
}
.divLine {
    border-bottom:2px silver solid;
}
.divLineCount {
    border-bottom:2px silver solid;
}
.divLineQuestionsCount {
    border-bottom:1px silver solid;
}
.divLineLabel {
    border-bottom:2px silver solid;
}

    </style>
    <script>
    
    
    <%
    	String username = "";
    	String username1 = "";
    	String firstName = "";
     	String lastName = "";
    	String userId = "";
    	HttpSession httpSession = request.getSession(false);
    	username = (String) httpSession.getAttribute("username");
    	firstName = (String) httpSession.getAttribute("firstName");
     	lastName = (String) httpSession.getAttribute("lastName");
    	userId = (String) httpSession.getAttribute("userId");
    	if(username==null||username.equals(""))
    		username1 = "no";
    	else
    		username1 = username;
    %>
    
    

    	var username = '<%=username%>';
    	var username1 = '<%=username1%>';
    	var firstName = '<%=firstName%>';
     	var lastName = '<%=lastName%>';
    	var userId = '<%=userId%>';
    	console.log(username);
    	console.log(username1);
    	console.log(userId);
    	
    $(document).ready(function() {
    	if(username1!="no")
    	{
    		console.log("first");
        	$('#login').hide();
        	$('#register').hide();
        	$('#logout').show();
        	$('#profile').show();
        	$('#profileName').text(firstName+" "+lastName);
        	$('#yourcontentDiv').show();
        	$("#profileName").attr("href", "editProfile?userId="+userId);
        	$("#profileName").attr("target", "_blank");
        	$("#editProfileTag").attr("href", "editProfile?userId="+userId);
         	$("#editProfileTag").attr("target", "_blank");
         	$("#questionsTag").attr("href", "profile?userId="+userId);
    	}
    	else
    	{
    		console.log("second");
    		$('#login').show();
    		$('#register').show();
        	$('#logout').hide();
        	$('#profile').hide();
        	$('#yourcontentDiv').hide();
    	}
    });
 
 $(document).ready(function(){
	 
	 function getSearchType(){
	   	 $.ajax({
			   	  type: "post",
			   	  url: "findSearchResults",
			   	  data: {"searchData": '${searchData}'},
			   	  cache: false,    
			   	  success: function(response){
				   	   var obj = JSON.parse(response);
				   	   console.log("response is: "+obj);
				   	 for (var i=0; i<obj.items.length; i++)
				   	 {
				   		 console.log(obj.items[i].searchData);
				   		console.log(obj.items[i].searchType);
				   		if(obj.items[i].searchType == "answer")
				   		{
				   			document.location.href = "displayAnswerResult?answer="+obj.items[i].searchData;
				   		}
				   		else if(obj.items[i].searchType == "question")
				   		{
				   			document.location.href = "displayAnswers?question="+obj.items[i].searchData;
				   		}
				   		else if(obj.items[i].searchType == "blog")
				   		{
				   			document.location.href = "getBlogs?blogTopic="+obj.items[i].searchData;
				   		}
				   		else if(obj.items[i].searchType == "profile")
				   		{
				   			document.location.href = "profile?userId="+obj.items[i].userId;
				   		}
				   	 }
			   	  },
			   	  error: function(){      
			   	   			alert('Error while request..');
			   	  }
	   	 });
	   }
	   	 
	   	getSearchType();
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
                <!--navbar-branding/logo - hidden image tag & site name so things like Facebook to pick up, actual logo set via CSS for flexibility -->
                <div class="navbar-slogan">
                  <h4 style="font-weight: bold; font-size: 30px">Thought Warehouse</h4>
<!--                   <br> -->
<!--                   By BootstrapMade.com -->
                </div>
              </div>
              <!--header rightside-->
              <div class="col-md-4">
                <!--user menu-->
<%--                 ${welcomeTitle} --%>
                <ul class="list-inline user-menu pull-right">
                  <li id = "profile" class="hidden-xs"><a id = "profileName" href="#"></a></li>
                  <li id = "register" class="hidden-xs"><i class="fa fa-edit text-primary"></i> <a href="${pageContext.request.contextPath}/signup" class="text-uppercase">Register</a></li>
                  <li id = "login" class="hidden-xs"><i class="fa fa-sign-in text-primary"></i> <a href="${pageContext.request.contextPath}/login" class="text-uppercase">Login</a></li>
                  <li id = "logout" class="hidden-xs"><i class="fa fa-sign-out text-primary"></i> <a href="${pageContext.request.contextPath}/logout" class="text-uppercase">Logout</a></li>
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
<!--                 <li><a href="#">Illinois Tech Blog</a></li> -->
                <li id="yourcontentDiv" class="dropdown dropdown-mm">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Your Content<b class="caret"></b></a>
                  <!-- Dropdown Menu -->
                  <ul class="dropdown-menu dropdown-menu-mm dropdown-menu-persist">
                   <li class="row">
                      <ul class="col-md-6">
                        <li class="dropdown-header">Blogs and Comments</li>
                        <li><a href="displayBlogPage">Blogs</a></li>
                        <li><a href="displayCommentPage">Comments</a></li>
                      </ul>
                      <ul class="col-md-6">
                        <li class="dropdown-header">Questions and Answers</li>
                        <li><a id = "questionsTag" href="#">Questions</a></li>
                        <li><a href="displayAnswerPage">Answers</a></li>
                      </ul>
                      <ul class="col-md-6">
                        <li class="dropdown-header">Profile</li>
                        <li><a id="editProfileTag" href="#">Profile</a></li>
                      </ul>
                    </li>
                  </ul>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    
	
	
	
	

    
    <!-- ======== @Region: #content ======== -->
    <div id="content">
      
      <!--Customer testimonial & Latest Blog posts-->
      <div class="testimonials block-contained">
        <div id="main-content" class="row">
        
          <!--Customer testimonial-->
          <div id = "questions" class="col-md-6 m-b-lg">
          </div>
          
          <!--Latest Blog posts-->
          <div id = "blogs" class="col-md-6 blog-roll">
            <h3 class="block-title">
              Latest From Our Blog
            </h3>
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
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/bootstrap/js/bootstrap.min.js"></script>
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