<%-- 
    Document   : studentEditProfile
    Created on : Jan 11, 2021, 8:50:29 AM
    Author     : Wen Jie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="bean.User" %>
<%@ page import="bean.Student" %>

<c:if test="${sessionScope.user == null || sessionScope.student == null }">
    <c:redirect url="/notAuthorized.jsp" />   
</c:if>

<c:if test="${sessionScope.user == null || sessionScope.student == null }">
    <c:redirect url="/notAuthorized.jsp" />   
</c:if>

<jsp:useBean id="user" class="bean.User" scope="session" />
<jsp:useBean id="student" class="bean.Student" scope="session" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <style>
         .bd-placeholder-img {
           font-size: 1.125rem;
           text-anchor: middle;
           -webkit-user-select: none;
           -moz-user-select: none;
           -ms-user-select: none;
           user-select: none;
         }

         @media (min-width: 768px) {
           .bd-placeholder-img-lg {
             font-size: 3.5rem;
           }
         }
      </style>

      <!-- Custom styles for this template -->
      <link href="css/navbar-top-fixed.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
         <div class="container">
            <a class="navbar-brand" href="#">CRAS </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarCollapse">

               <ul class="navbar-nav mr-auto">
                  <li class="nav-item ">
                    <a class="nav-link" href="studentHome.jsp">Home </a>
                  </li>                  
                  <li>
                     <a class="nav-link" href="StudentViewApplicationServlet">College Application</a>
                  </li>
                  <li>
                     <a class="nav-link active" href="studentProfile.jsp">Profile </a>
                  </li>
               </ul>
                
                <div class="form-inline mt-2 mt-md-0">
                   <a class="btn btn-danger my-2 my-sm-0"  href="LogoutServlet"> Logout </a>
               </div>

            </div>
         </div>
      </nav>     
        <main role="main" class="container">
        <nav aria-label="breadcrumb">
               <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="studentProfile.jsp">Profile</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Edit Profile</li>
               </ol>
            </nav>
            
            <c:if test="${param.message != null}"> 
                <div class="alert alert-danger" role="alert"> ${param.message} </div>
            </c:if>
 
             <c:if test="${param.success != null}"> 
                <div class="alert alert-success" role="alert"> ${param.success} </div>
            </c:if>
            
            <div class="card">
               <div class="container">
                   <div class="row justify-content-md-center">
                      <img src="img/${student.imagePath}" width="200px" class="rounded img-fluid">
                  </div>
                  <br>
                   <div class="row justify-content-md-center">
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#profileImgFormModel">
                        Change Profile Image
                        </button>
                  </div>
                   
                   <div class="row justify-content-md-center">
                       <div class="col col-md-6">
                        <form action="StudentUpdateProfileServlet" method="POST">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" class="form-control" id="username" name="username"  readonly value="${user.username}">
                         </div>
                         
                         <div class="form-group">
                            <label>Password</label>
                            <div class="input-group">
                            <input type="password" class="form-control" id="password" name="password"  readonly aria-describedby="basic-addon2" value="************">
                            <div class="input-group-append">
                                <a class="btn btn-primary align-content-center"  href="studentEditPassword.jsp"> Edit</a>
                            </div>
                            </div>
                         </div>
                         
                         
                         
                         <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" class="form-control" id="name" name="name"  required="true" value="${student.name}">
                         </div>
                         
                         <div class="form-group">
                            <label>Matric No.</label>
                            <input type="text" class="form-control" id="matricNo" name="matricNo" required="true" value="${student.matricNo}">
                         </div>
                         
                         <div class="form-group">
                            <label>Email address</label>
                            <input type="email" class="form-control" id="email" name="email"  required="true" value="${user.email}">
                         </div>
                         
                            <input type="hidden" id="studentID" name="studentID" value="${student.studentID}">
                                                 
                    
                      <div class="col text-center" style='padding-bottom: 20px;'>
                          <button class="btn btn-dark" type="submit" class="btn btn-primary align-content-center">Update</button>
                      </div>
                      </form>
                        </div>  
                    </div>
               </div>
            </div>  
                            
            <div class="modal fade" id="profileImgFormModel" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">Edit Profile Image</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                      <form method="post" action="StudentUpdateImageServlet" enctype="multipart/form-data">
                      <input type="hidden" id="studentID2" name="studentID" value="${student.studentID}">    
                        <div class="modal-body">
                            <div id="chosenImg"></div>
                                Select file to upload:
                                <input type="file" id="uploadFile" name="uploadFile" />
                        </div>
                          
                        <div class="modal-footer">
                          <button type="submit" class="btn btn-primary">Save changes</button>
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                      </form>
                  </div>
                </div>
              </div>                  
           
        </main>

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
      <script>
          $("#uploadFile").change(function(e) {
            for (var i = 0; i < e.originalEvent.srcElement.files.length; i++) {

                var file = e.originalEvent.srcElement.files[i];

                var img = document.createElement("img");
                var reader = new FileReader();
                reader.onloadend = function() {
                     img.src = reader.result;
                }
                reader.readAsDataURL(file);
                $("#chosenImg").html(img);
            }
        });
        
        $('#profileImgFormModel').on('hidden.bs.modal', function (e) {
            $("#chosenImg").empty();
            $("#uploadFile").val(null);
          });
      </script>
    </body>
</html>
