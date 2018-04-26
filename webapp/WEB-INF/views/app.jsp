<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ITMD 565 Project 1 - apannu</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="${pageContext.request.contextPath}/bootstrap-course/new1/style.css" rel="stylesheet">
    <!--bootstrap plugin-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> <!--Google icon plugin-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css">
    <!--materailize css plugin-->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> <!--bootstrap plugin-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> <!--jQuery Plugin-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/js/materialize.min.js"></script>
<script>
window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;

if(!window.indexedDB)
{
    console.log("Your Browser does not support IndexedDB");
}
else
{
    console.log("Your Browser supports IndexedDB");
}
</script>
</head>
<body>
<div class="container topMargin">
    <div class="headingCenter topMargin">
        <b>Personal Notes Saver</b>
    </div>

    <div class="row">
        <form class="col s12" id="mainContent">
            <div class="row" style="margin-bottom: 0px;">
                <div class="input-field col s2">
<!--                     <input id="title_authorname" type="text" class="validate"> -->
<!--                     <label for="title_content">Author Name</label> -->
					<label class="control-label" for="username">Username</label>
                  	<input type="text" name="username" id="username" data-toggle="tooltip" data-placement="right" />
                </div>
            </div>
            <div class="row">
                <div class="input-field col s11">
<!--                     <input id="title_content" type="text" class="validate"> -->
<!--                     <label for="title_content">Note Subject</label> -->
					<label class="control-label" for="subject">Subject</label>
                  	<input type="text" name="subject" id="subject" data-toggle="tooltip" data-placement="right" />
                    <textarea class="form-control" rows="1" id="comment"
                              placeholder="Please enter your note deails"></textarea>
                </div>
                <div class="col s1">
<!--                     <a class="btn-floating btn-large red" id="checkIcon">Add</a> -->
<!--                     <a href="https://material.io/icons/#ic_add_circle_outline"></a> -->
						<button id = "addButton" class="btn btn-default">Add</button>
                </div>
            </div>
        </form>
    </div>

    <hr>

    <div class="row">
        <div class="input-field col s10">
        </div>
        <div class="input-field col s2" style="margin-bottom: 20px;">

            <label id="count" style="font-weight: bold; font-size: large;">Count: 0</label>
        </div>
    </div>

    <div class="row" id="toDoList">
        <!--add dynamic content here...-->
    </div>

</div>
</body>
</html>