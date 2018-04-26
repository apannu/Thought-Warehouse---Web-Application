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
    
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/css/bootstrap-imageupload.css" rel="stylesheet">
    
    <!--Your custom colour override - predefined colours are: colour-blue.css, colour-green.css, colour-lavander.css, orange is default-->
    <link href="#" id="colour-scheme" rel="stylesheet">
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
    
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/jquery/jquery.min.js"></script>
    
	<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
    
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/lib/bootstrap/js/bootstrap.min.js"></script>
    
    <script src="${pageContext.request.contextPath}/bootstrap-course/new1/js/bootstrap-imageupload.js"></script>
    
    <style>
    
     .imageupload {
                margin: 20px 0;
            }
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
 	width: 50px;
    height: 50px;
    border: 4px solid #FFF;
    margin: 10px;
}
.aParent div {
    float: left;
    clear: none; 
}
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
.modal-dialog{
    overflow-y: initial !important;
/*     width: 555px; */
    vertical-align: middle;
}
.modal-body{
/*     height: 70px; */
    overflow-y: auto;
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
 	
 	//for fb login
	String fbName = "";
	String fbUserId = "";
	fbName = (String) httpSession.getAttribute("fbUsername");
	fbUserId = (String) httpSession.getAttribute("fbUserId");
	if(fbName==null||fbName.equals(""))
 		fbName = "no";
	//ends here
 %>

 	var username = '<%=username%>';
 	var username1 = '<%=username1%>';
 	console.log(username);
 	console.log(username1);
 	
 	//for fb login
	var fbName = '<%=fbName%>';
	var fbUserId = '<%=fbUserId%>';
	console.log(fbUserId);
 	console.log("fb name: "+fbName);
	//ends here
 	
 	//code for read more blog functionality
 	function showReadMoreBlogContent(originalBlogContent, blogContentId, readMoreId)
 	{
 		if (document.getElementById(readMoreId).innerHTML == "Show More")
 		{
 			document.getElementById(readMoreId).innerHTML = "Show Less";
 			document.getElementById(blogContentId).innerHTML = originalBlogContent;
 		}
 		else if (document.getElementById(readMoreId).innerHTML == "Show Less")
 		{
 			document.getElementById(readMoreId).innerHTML = "Show More";
 			document.getElementById(blogContentId).innerHTML = document.getElementById(blogContentId).innerHTML.substring(0,400)+"..........";
 		}
 	}
 	
	//code for read more answer functionality
 	function showReadMoreAnswerContent(originalAnswerContent, answerContentId, readMoreId)
 	{
 		if (document.getElementById(readMoreId).innerHTML == "Show More")
 		{
 			document.getElementById(readMoreId).innerHTML = "Show Less";
 			document.getElementById(answerContentId).innerHTML = originalAnswerContent;
 		}
 		else if (document.getElementById(readMoreId).innerHTML == "Show Less")
 		{
 			document.getElementById(readMoreId).innerHTML = "Show More";
 			document.getElementById(answerContentId).innerHTML = document.getElementById(answerContentId).innerHTML.substring(0,400)+"..........";
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
		
	 $("#logoutStatusDiv").hide();
	 var temp = '${logoutStatus}';
		if(temp!="")
		{
			console.log(temp);
			$("#logoutStatusDiv").show();
			$("#logoutStatusDiv").fadeTo(8000, 500).slideUp(500, function(){
			    $("#logoutStatusDiv").slideUp(500);
	     }); 
		 	$(".alert").alert();
		}
		
		if(username1!="no" || fbName!="no")
	 	{
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
	     	//check the FB login
	    	if(fbName!="no")
	     	{
	     		console.log("second");
	         	$('#login').hide();
	         	$('#register').hide();
	         	$('#logout').show();
	         	$('#profile').show();
	         	$('#profileName').text(fbName);
	         	$('#yourcontentDiv').show();
	         	$("#profileName").attr("href", "editProfile?userId="+fbUserId);
	         	$("#profileName").attr("target", "_blank");
	         	$("#editProfileTag").attr("href", "editProfile?userId="+fbUserId);
	         	$("#editProfileTag").attr("target", "_blank");
	         	$("#questionsTag").attr("href", "profile?userId="+fbUserId);
	     	}
	 	}
	 	else
	 	{
	 		console.log("third");
	 		$('#login').show();
	 		$('#register').show();
	     	$('#logout').hide();
	     	$('#profile').hide();
	     	$('#yourcontentDiv').hide();
	 	}
 });
    
 function displayQuestions(){
   	 $.ajax({
   	  type: "post",
   	  url: "topQuestions",
   	  cache: false,    
   	  success: function(response){
   	   var obj = JSON.parse(response);
   	   var output = document.getElementById('questionsAndAnswers');
   	   console.log(obj);
   	   for (var i=0; i<obj.items.length; i++)
   	   {
   		   	  var newDiv = document.createElement("div");
              newDiv.setAttribute("id","div"+i);
              newDiv.style.border = "1px solid";
              newDiv.style.borderColor = "silver";
              newDiv.style.borderRadius = "10px";
              newDiv.style.marginBottom = "10px";
              newDiv.style.width = "540px";
              
              var strong = document.createElement("h4");
              strong.setAttribute("id", "strong"+i);
              strong.style.fontWeight="bold";
              strong.style.paddingLeft = "0.5cm";
              strong.style.paddingRight = "0.5cm";
              strong.style.paddingTop = "0.1cm";
              
              var a = document.createElement('a');
              a.setAttribute('id', 'questionTag');
              a.setAttribute('href',"#");
              a.innerHTML = obj.items[i].question_name;
              a.style.color = "#000000";
              a.style.fontSize = "0.9em";
              a.href="displayAnswers?question="+obj.items[i].question_name;
              a.target="_blank"
			  strong.appendChild(a);
			  
              var pTag = document.createElement("p");
              pTag.setAttribute("id", "pa"+i)
              pTag.style.paddingLeft = "0.5cm";
              pTag.style.paddingRight = "0.5cm";
              pTag.style.paddingBottom = "0.1cm";
              pTag.style.paddingTop = "1cm";
              
            //start of code to handle read more
              var originalAnswer = obj.items[i].answer_name;
              
              if(originalAnswer.length>401)
            	  var pTagTextNode = document.createTextNode(originalAnswer.substring(0,401)+"..........");
              else
            	  var pTagTextNode = document.createTextNode(originalAnswer);
              
              pTag.appendChild(pTagTextNode);
              
              var aDiv = document.createElement("div");
              aDiv.setAttribute("id","aDivAnswer");
              aDiv.style.marginBottom = "10px";
              
              var readMoreA = document.createElement('a');
              readMoreA.setAttribute('id', 'readMoreA'+i);
              readMoreA.setAttribute('href',"#");
              readMoreA.innerHTML = "Show More"
              readMoreA.style.color = "##F00";
              readMoreA.style.fontSize = "0.9em";
              readMoreA.style.fontWeight = "bold";
              readMoreA.style.paddingLeft = "0.5cm";
              readMoreA.style.paddingBottom = "0.5cm";
              readMoreA.href = 'javascript:showReadMoreAnswerContent("' + originalAnswer.replace(/"/g, '\\"') + '", "pa"+"'+i+'", "readMoreA"+"'+i+'")';
              
              aDiv.appendChild(readMoreA);
              //end of code to handle read more
              
              var mainDiv = document.createElement("div");
              mainDiv.className = "aParent";
              
              var imageDiv = document.createElement("div");
              var labelDiv = document.createElement("div");
              labelDiv.style.marginTop = "12px";
              
              var image = document.createElement("img");
              console.log(obj.items[i].imageFlag);
              if(obj.items[i].imageFlag=="Y")
            	  image.src = "profilePic?userId="+obj.items[i].userId;
              else
            	  image.src = "${pageContext.request.contextPath}/bootstrap-course/new1/img/no-profile-pic.png";
              image.className = "image-circle";
              
              var a2 = document.createElement('a');
			  a2.href="profile?userId="+obj.items[i].userId;
			  a2.target="_blank";
              a2.style.color = "#000000";
              
              a2.appendChild(image);
              
              var label = document.createElement('label');
              
              //start of code to handle empty values
	              var professionVal = obj.items[i].profession;
	              if(professionVal.length == 0)
	            	  professionVal = "";
	              else
	            	  professionVal = ", "+professionVal;
	              
	              var companyVal = obj.items[i].company_name;
	              if(companyVal.length == 0)
	            	  companyVal = "";
	              else
	            	  companyVal = ", "+companyVal;
	              
	              var lastNameVal = obj.items[i].last_name;
	              if(lastNameVal.length == 0)
	            	  lastNameVal = "";
	              else
	            	  lastNameVal = lastNameVal;
	              //end of code to handle empty values
              
              var a1 = document.createElement('a');
              a1.href="profile?userId="+obj.items[i].userId;
			  a1.target="_blank";
              a1.innerHTML = obj.items[i].first_name+" "+lastNameVal+professionVal+companyVal;
              a1.style.color = "##F00";
			  
			  label.appendChild(a1);
              
              var pTime = document.createElement("p");
              pTime.style.fontSize = "12px";
              
              var educationVal = obj.items[i].education;
	              if(educationVal.length==0)
	            	  	educationVal = "Education not provided";
	              
	          var pTimeTextNode = document.createTextNode(educationVal);
              pTime.appendChild(pTimeTextNode);
              
              var timeDiv = document.createElement("div");
              timeDiv.style.marginTop = "47px";
              timeDiv.style.marginBottom = "-30px";
              
              timeDiv.appendChild(pTime);

			  imageDiv.appendChild(a2);
			  labelDiv.appendChild(label);
			  
			  mainDiv.appendChild(imageDiv);
			  mainDiv.appendChild(labelDiv);
			  
              newDiv.appendChild(strong);
              newDiv.appendChild(mainDiv);
			  newDiv.appendChild(timeDiv);
              newDiv.appendChild(pTag);
              if(originalAnswer.length>401)
                	newDiv.appendChild(aDiv);
              output.appendChild(newDiv);
   	   }
   	displayBlogs();
   	  },
   	  error: function(){      
   	   alert('Error while request..');
   	  }
   	 });
   }
    
 displayQuestions();
    
    //display blogs
       function displayBlogs(){
   	 $.ajax({
   	  type: "post",
   	  url: "displayBlogs",
   	  cache: false,    
   	  success: function(response){
   	   var obj = JSON.parse(response);
   	   var output = document.getElementById('blogs');
   	   console.log(obj);
   	   for (var i=0; i<obj.items.length; i++)
   	   {
   		   	  var newDiv = document.createElement("div");
              newDiv.setAttribute("id","div"+i);
              newDiv.style.border = "1px solid";
              newDiv.style.borderColor = "silver";
              newDiv.style.borderRadius = "10px";
              newDiv.style.marginBottom = "10px";
              newDiv.style.width = "555px";
              
              var strong = document.createElement("h4");
              strong.setAttribute("id", "strong"+i);
              strong.style.fontWeight="bold";
              strong.style.paddingLeft = "0.5cm";
              strong.style.paddingRight = "0.5cm";
              strong.style.paddingTop = "0.1cm";
              
              var a = document.createElement('a');
              a.setAttribute('id', 'questionTag');
              a.setAttribute('href',"#");
              a.innerHTML = obj.items[i].blogTopic;
              a.style.color = "#000000";
              a.style.fontSize = "0.9em";
              a.href="getBlogs?blogTopic="+obj.items[i].blogTopic;
              a.target="_blank"
			  strong.appendChild(a);
			  
              var pTag = document.createElement("p");
              pTag.setAttribute("id", "pb"+i)
              pTag.style.paddingLeft = "0.5cm";
              pTag.style.paddingRight = "0.5cm";
              pTag.style.paddingBottom = "0.1cm";
              pTag.style.paddingTop = "1cm";
              pTag.align = "left";
              
              //start of code to handle read more
              var originalBlogContent = obj.items[i].blogContent;
              
              if(originalBlogContent.length>401)
            	  var pTagTextNode = document.createTextNode(originalBlogContent.substring(0,401)+"..........");
              else
            	  var pTagTextNode = document.createTextNode(originalBlogContent);
              
              pTag.appendChild(pTagTextNode);
              
              var aDiv = document.createElement("div");
              aDiv.setAttribute("id","aDivBlog");
              aDiv.style.marginBottom = "10px";
              
              var readMoreB = document.createElement('a');
              readMoreB.setAttribute('id', 'readMoreB'+i);
              readMoreB.setAttribute('href',"#");
              readMoreB.innerHTML = "Show More"
              readMoreB.style.color = "##F00";
              readMoreB.style.fontSize = "0.9em";
              readMoreB.style.fontWeight = "bold";
              readMoreB.style.paddingLeft = "0.5cm";
              readMoreB.style.paddingBottom = "0.5cm";
              readMoreB.href = 'javascript:showReadMoreBlogContent("' + originalBlogContent.replace(/"/g, '\\"') + '", "pb"+"'+i+'", "readMoreB"+"'+i+'")';
              
              aDiv.appendChild(readMoreB);
              //end of code to handle read more
              
              var mainDiv = document.createElement("div");
              mainDiv.className = "aParent";
              
              var imageDiv = document.createElement("div");
              var labelDiv = document.createElement("div");
              labelDiv.style.marginTop = "12px";
              
              var image = document.createElement("img");
              console.log(obj.items[i].imageFlag);
              if(obj.items[i].imageFlag=="Y")
            	  image.src = "profilePic?userId="+obj.items[i].userId;
              else
            	  image.src = "${pageContext.request.contextPath}/bootstrap-course/new1/img/no-profile-pic.png";
              image.className = "image-circle";
              
              var a2 = document.createElement('a');
			  a2.href="profile?userId="+obj.items[i].userId;
			  a2.target="_blank";
              a2.style.color = "#000000";
              
              a2.appendChild(image);
              
              var label = document.createElement('label');
              
              //start of code to handle empty values
              var professionVal = obj.items[i].profession;
              if(professionVal.length == 0)
            	  professionVal = "";
              else
            	  professionVal = ", "+professionVal;
              
              var companyVal = obj.items[i].company;
              if(companyVal.length == 0)
            	  companyVal = "";
              else
            	  companyVal = ", "+companyVal;
              
              var lastNameVal = obj.items[i].lname;
              if(lastNameVal.length == 0)
            	  lastNameVal = "";
              else
            	  lastNameVal = lastNameVal;
              //end of code to handle empty values
              
              var a1 = document.createElement('a');
              a1.href="profile?userId="+obj.items[i].userId;
			  a1.target="_blank";
              a1.innerHTML = obj.items[i].fname+" "+lastNameVal+professionVal+companyVal;
              a1.style.color = "##F00";
			  
			  label.appendChild(a1);
              
              var pTime = document.createElement("p");
              pTime.style.fontSize = "12px";
              
              var educationVal = obj.items[i].education;
	              if(educationVal.length==0)
	            	  	educationVal = "Education not provided";
	              
	              var pTimeTextNode = document.createTextNode(educationVal);
              pTime.appendChild(pTimeTextNode);
              
              var timeDiv = document.createElement("div");
              timeDiv.style.marginTop = "47px";
              timeDiv.style.marginBottom = "-30px";
              
              timeDiv.appendChild(pTime);

			  imageDiv.appendChild(a2);
			  labelDiv.appendChild(label);
			  
			  mainDiv.appendChild(imageDiv);
			  mainDiv.appendChild(labelDiv);
			  
              newDiv.appendChild(strong);
              newDiv.appendChild(mainDiv);
			  newDiv.appendChild(timeDiv);
              newDiv.appendChild(pTag);
              if(originalBlogContent.length>401)
              	newDiv.appendChild(aDiv);
              output.appendChild(newDiv);
   	   }
   	  },
   	  error: function(){      
   	   alert('An error occured while trying to display the trending blogs.');
   	  }
   	 });
   }
    
       function logoutUser()
   	{
   	    Logout();
   	    document.location.href = "logout";
   	}

   function showLoginModule()
   {
   	 $('#loginDivModal').modal('show');
   } 

   function submitFBForm()
   	{
   		if(!validateFBForm())
   		{
   			document.getElementById("fbRegisterForm").submit();
   		}
   	}
   	
   	function validateFBForm()
   	{
   		
   	var emailIdFlg = false;
   	var contactFlg = false;
   	var companyFlg = false;
   	var professionFlg = false;
   	var educationFlg = false;
   	
   	//empty all the validation divs
   	document.getElementById("validationEmailId").innerHTML = "";
   	document.getElementById("validationContact").innerHTML = "";
   	document.getElementById("validationCompany").innerHTML = "";
   	document.getElementById("validationProfession").innerHTML = "";
   	document.getElementById("validationEducation").innerHTML = "";

   	//define variables to get the field values
   	var emailIdValue = document.getElementById("fbEmailId").value;
   	var contactValue = document.getElementById("fbContact").value;
   	var companyValue = document.getElementById("companyName").value;
   	var professionValue = document.getElementById("professionName").value;
   	var educationValue = document.getElementById("educationName").value;
   	
   	//code for email validation
   	if(emailIdValue.length == 0){
   		
   		document.getElementById("validationEmailId").innerHTML = "<li>Please enter an email id.</li>";
   		$("#emailId").prop('required',true);
   		emailIdFlg = true;
   	}
   	else if(!emailIdValue.length == 0)
   	{
   		if (!emailIdValue.match(/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/))
   		{
   			document.getElementById("validationEmailId").innerHTML += "<li>Please enter the email id in a correct format.</li>";
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
   		if (!contactValue.match(/^\+?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/))
   		{
   			document.getElementById("validationContact").innerHTML += "<li>Please enter the contact number in a correct format.</li>";
   			contactFlg = true;
   		}
   		if(contactValue.length > 11)
   		{
   			document.getElementById("validationContact").innerHTML += "<li>Contact must contain at most 11 characters including (+) character.</li>";
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
   		if(companyValue.length > 100)
   		{
   			document.getElementById("validationCompany").innerHTML += "<li>Company details must contain at most 100 characters.</li>";
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
   		if(professionValue.length > 200)
   		{
   			document.getElementById("validationProfession").innerHTML += "<li>Profession details must contain at most 200 characters.</li>";
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
   		if(educationValue.length > 200)
   		{
   			document.getElementById("validationEducation").innerHTML += "<li>Education details must contain at most 200 characters.</li>";
   			educationFlg = true;
   		}
   	}
   	else
   	{
   		
   		document.getElementById("validationEducation").innerHTML = "";
   		educationFlg = false;
   	}
   	console.log("11 "+educationFlg);
   	
   	if(emailIdFlg || contactFlg || companyFlg || professionFlg || educationFlg){
   		   return true;
   	   }else{
   		   return false;
   	   }
   	}
   	
   	function submitLoginForm()
   	{
   		document.getElementById("loginForm").submit();
   	}
    
    </script>
    
  </head>
  
  <body class="page-index has-hero">
  <div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '893389597503420', // Set YOUR APP ID
//       channelUrl : 'http://hayageek.com/examples/oauth/facebook/oauth-javascript/channel.html', // Channel File
      status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });
 
    FB.Event.subscribe('auth.authResponseChange', function(response) 
    {
     if (response.status === 'connected') 
    {
    }    
    else if (response.status === 'not_authorized') 
    {
         
    } else 
    {
    }
    }); 
 
    };
 
    function Login()
    {
        FB.login(function(response) {
           if (response.authResponse) 
           {
                getUserInfo();
            } else 
            {
             console.log('User cancelled login or did not fully authorize.');
            }
         },{scope: 'email,public_profile,user_friends'});
        $('#loginDivModal').modal('hide');
 
    }
    
    
 
  function getUserInfo() {
        FB.api('/me', function(response) {
        	
        	fbName = response.name;
        	console.log(fbName);
        	if(fbName!=null)
        	{
        		$.ajax({
        		   	  type: "post",
        		   	  url: "checkFBUser",
        		   	  data: {"fbName": fbName},
        		   	  cache: false,    
        		   	  success: function(response1){
        		   	   alert("response1: "+response1);
        		   	   
        		   	$('#login').hide();
                 	$('#register').hide();
                 	$('#logout').show();
                 	$('#profile').show();
                 	$('#profileName').text(fbName);
                 	$('#yourcontentDiv').show();
                 	$("#profileName").attr("href", "editProfile?userId="+response1);
                 	$("#profileName").attr("target", "_blank");
                 	$("#editProfileTag").attr("href", "editProfile?userId="+response1);
                 	$("#editProfileTag").attr("target", "_blank");
                 	$("#questionsTag").attr("href", "profile?userId="+response1);
        		   	   
        		   	   if(response1==0)
        		   	   {
		        		   		$.ajax({
		              		   	  type: "post",
		              		   	  url: "saveFBUserName",
		              		   	  data: {"fbName": fbName},
		              		   	  cache: false,    
		              		   	  success: function(response){
		              		   		alert("response: "+response);
		              		   		$('#login').hide();
		        	             	$('#register').hide();
		        	             	$('#logout').show();
		        	             	$('#profile').show();
		        	             	$('#profileName').text(fbName);
		        	             	$('#yourcontentDiv').show();
		        	             	$("#profileName").attr("href", "editProfile?userId="+response);
		        	             	$("#profileName").attr("target", "_blank");
		        	             	$("#editProfileTag").attr("href", "editProfile?userId="+response);
		        	             	$("#editProfileTag").attr("target", "_blank");
		        	             	$("#questionsTag").attr("href", "profile?userId="+response);
		        	             	document.getElementById("fbUserId").value = response;
		              		   	  },
		              		   	  error: function(){      
		              		   	   alert('Error while saving the username initially.');
		              		   	  }
		              		   	 });
        		   		   
        		   		document.getElementById("fbProfileName").value = fbName;
	        		   	//submit the form and add a fbUser
	               		$('#fbRegisterModalDiv').modal('show');
        		   	   }
        		   	  },
        		   	  error: function(){      
        		   	   alert('Error while checking the FB user id..');
        		   	  }
        		   	 });
        	}
    });
    }
    function getPhoto()
    {
      FB.api('/me/picture?type=normal', function(response) {
 
          var str="<br/><b>Pic</b> : <img src='"+response.data.url+"'/>";
          document.getElementById("status").innerHTML+=str;
 
    });
 
    }
    function Logout()
    {
        FB.logout(function(){document.location.reload();});
    }
 
  // Load the SDK asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
 
</script>
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
                  <h4 style="font-weight: bold; font-size: 30px">Thought Warehouse</h4>
                </div>
              </div>
              <!--header rightside-->
              <div class="col-md-4">
                <!--user menu-->
                <ul class="list-inline user-menu pull-right">
                  <li id = "profile" class="hidden-xs"><a href="register.html" class="text-uppercase">${welcomeTitle}</a></li>
                  <li id = "register" class="hidden-xs"><i class="fa fa-edit text-primary"></i> <a href="${pageContext.request.contextPath}/signup" class="text-uppercase">Register</a></li>
                  <li id = "login" class="hidden-xs"><i class="fa fa-sign-in text-primary"></i> <a href="javascript:showLoginModule()" class="text-uppercase">Login</a></li>
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
          <div class="alert alert-info" id="logoutStatusDiv">
		      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		      ${logoutStatus}
		    </div>
		    
          <div id = "questionsAndAnswers" class="col-md-6 m-b-lg">
            <h3 class="block-title">
              Top Questions
            </h3>
          </div>
          
           <!--Latest Blog posts-->
          <div id = "blogs" class="col-md-6 blog-roll">
            <h3 class="block-title">
              Latest From Our Blog
            </h3>
          </div>
          
          <!-- Modal for login -->
			  <div class="modal fade" id="loginDivModal" role="dialog">
			    <div class="modal-dialog" data-backdrop="static" data-keyboard="false">
			      <!-- Modal content-->
			      <div class="modal-content">
			        <div class="modal-header">
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			          <h3 class="modal-title">Choose a Login Method</h3>
			        </div>
			        <div class="modal-body" id="login-content">
				          <div class="form">
				          <div class="aParent">
							<div style="margin-right: 20px"><button type="button" class="btn btn-fb" style="background-color: #3b5998; color: white; width: 250px" onclick="Login()"><i class="fa fa-facebook left"></i> &nbsp;&nbsp;&nbsp;&nbsp;Log in using Facebook</button></div>
							<div><button type="button" class="btn btn-fb" style="background-color: orange; color: white" onclick="submitLoginForm()"><i class="fa fa-sign-in left"></i> &nbsp;&nbsp;Log in using Thought Warehouse</button></div>
 	            		</div>
 	            		<form:form id="loginForm" action = "login" name ="loginForm" method="post" role="form" modelAttribute="login" enctype="multipart/form-data">
 	            		</form:form>
 	            		</div>
			        </div>
			      </div>
			    </div>
			  </div>
			  
			   <!-- Modal for FB Register -->
			  <div class="modal fade" id="fbRegisterModalDiv" role="dialog">
			    <div class="modal-dialog">
			      <!-- Modal content-->
			      <div class="modal-content">
			        <div class="modal-header">
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			          <h3 class="modal-title">Create your Profile</h3>
			        </div>
			        <div class="modal-body" id="login-content">
				          <div class="form">
 	            		<form:form id="fbRegisterForm" action = "fbRegister" name ="fbRegisterForm" method="post" role="form" modelAttribute="userDTO" enctype="multipart/form-data">
 	            		 <div class="form-group">
					  	  			<div class="imageupload panel panel-default">
					                	<div class="panel-heading clearfix">
						                    <h3 class="panel-title pull-left">Change Profile Picture</h3>
						                    <div class="btn-group pull-right"></div>
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
					                  <div id="profileNameDivFBUser"><input type="hidden" name="fbProfileName" id="fbProfileName"/></div>
					                  <div id="fbIdDivFBUser"><input type="hidden" name="fbUserId" id="fbUserId"/></div>
					                  <div class="form-group">
					                  <label class="control-label" for="fbEmailId">Email Id</label>
					                    <input type="email" class="form-control" name="fbEmailId" id="fbEmailId" placeholder="Email Id" data-toggle="tooltip" data-placement="bottom" 
					                  	title="Email Id must contain @ character, alphabets and numbers. For eg. apannu@hawk.iit.edu, pannuanirudh@gmail.com"/>
					                    <div id="validationEmailId" style="color:#A52A2A"></div>
					                  </div>
					                      <div class="form-group">
					                      <label class="control-label" for="fbContact">Contact</label>
					                    <input type="text" class="form-control" name="fbContact" id="fbContact" placeholder="Contact" data-toggle="tooltip" data-placement="top" 
					                  	title="Contact can contain a (+), (-) and (.) characters, and must be alphanumeric. For eg. 312-866-7564, +3128667564"/>
					                    <div id="validationContact" style="color:#A52A2A"></div>
					                  </div>
					                  <div class="form-group">
					                     <label class="control-label" for="company">Company</label>
					                    <input type="text" class="form-control" name="companyName" id="companyName" placeholder="Company" data-toggle="tooltip" data-placement="top" 
					                  	title="Company can contain a (.), (,), (&) and (-) characters. For eg. Capgemini - India, Capgemini"/>
					                    <div id="validationCompany" style="color:#A52A2A"></div>
					                  </div>
					                  <div class="form-group">
					                  	<label class="control-label" for="profession">Profession</label>
					                    <textarea class="form-control" name="professionName" id="professionName" rows="2" placeholder="Profession" data-toggle="tooltip" data-placement="top" 
					                  	title="Profession can contain a (.), (,), (&) and (-) characters. For eg. Senior Software Engineer: Consultant, Lead Developer & Manager">${professionName}</textarea>
					                    <div id="validationProfession" style="color:#A52A2A"></div>
					                  </div>
					                   <div class="form-group">
					                   <label class="control-label" for="education">Education</label>
					                    <textarea class="form-control" name="educationName" id="educationName" rows="2" placeholder="Education" data-toggle="tooltip" data-placement="top" 
					                  	title="Education can contain a (.), (,), (&) and (-) characters. For eg. Master of Science: Information Technology - Software Developement, Bachelor of Science & Master of Sciencce">${educationName}</textarea>
					                    <div id="validationEducation" style="color:#A52A2A"></div>
					                  </div>
 	            		</form:form>
 	            		</div>
			        </div>
			        <div class="modal-footer">
			          <button type="button" class="btn" onClick="submitFBForm()">Submit</button>
			        </div>
			      </div>
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
    
     <script>var $imageupload = $('.imageupload');
    $imageupload.imageupload();</script>
  
  </body>
</html>