<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <title>Sign Up Form</title>
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

  <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-course/new1/style1.css">
      
</head>

<body>
  
<div class="container">
  <form>
    <div class="row" id="mainContent">
    <div id="secondaryContent">
	      <h2>Add Notes</h2>
	      <div class="input-group input-group-icon">
	        <input type="text" id= "authorName" placeholder="Author Name"/>
	        <div class="input-icon"><i class="fa fa-user"></i></div>
	      </div>
	      <div class="input-group input-group-icon">
	        <input type="text" id= "noteSubject" placeholder="Note Subject"/>
	        <div class="input-icon"><i class="fa fa-envelope"></i></div>
	      </div>
	      <div class="input-group input-group-icon">
	        <input type="text" id= "noteContent" placeholder="Enter your notes"/>
	        <div class="input-icon"><i class="fa fa-pencil-square-o"></i></div>
	      </div>
	      <div>
	      </div>
      </div>
      <div class="list-group" id="addNoteButtonDiv">
  		 <a class="list-group-item" style="text-decoration:none" href="#" id="addNote"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add</a>
	  </div>
      
    </div>
       <div class="row">
        <div class="input-field col s10">
        </div>
        <div id="labelDiv" class="input-field col s2">
            <label id="countLabel" style="font-weight: bold; font-size: large; color: #7ed321"></label>
        </div>
        <div id="borderDiv">
        </div>
    </div>
     <div class="row" id="toDoList">
        <!--add dynamic content here...-->
    </div>
  </form>
</div>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

    <script  src="${pageContext.request.contextPath}/bootstrap-course/new1/js/index.js"></script>

</body>
</html>
