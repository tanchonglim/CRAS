<%-- 
    Document   : studentEditPassword
    Created on : Jan 11, 2021, 10:28:13 AM
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
        <title>Edit User Password</title>
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
                  <li class="breadcrumb-item"><a href="studentHome.jsp">Home</a></li>
                  <li class="breadcrumb-item"><a href="studentProfile.jsp">Profile</a></li>
                  <li class="breadcrumb-item"><a href="studentEditProfile.jsp">Edit Profile</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Edit User Password</li>
               </ol>
            </nav>
            
            <div class="card">
               <div class="container">
                                      
                   <div class="row justify-content-md-center">
                       <div class="col col-md-6">
                        <form action="StudentUpdatePasswordServlet" method="POST">
                        <div class="form-group">
                            <label>Current Password</label>
                            <input type="password" class="form-control" id="password" name="password" required="true">
                         </div>
                                                  
                         <div class="form-group">
                            <label>New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword"  required="true">
                         </div>
                         
                        <div class="form-group">
                          <label for="exampleInputPassword1">Password Confirmation</label>
                          <input type="password" class="form-control" id="passwordConfirm" required="true">
                        </div>
                         
                        <input type="hidden" id="studentID" name="studentID" value="${student.studentID}">
                                                 
                      </dl>
                      <div class="col text-center" style='padding-bottom: 20px;'>
                          <button type="submit" class="btn btn-primary align-content-center">Update Password</button>
                      </div>
                      </form>
                        </div>  
                    </div>
               </div>
            </div>  
           
        </main>

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
      
      <script>
            var password = document.getElementById("password")
            ,newPassword = document.getElementById("newPassword")
            , confirm_password = document.getElementById("passwordConfirm");

            
          function validateNewPassword(){
            if(newPassword.value !== confirm_password.value) {
              confirm_password.setCustomValidity("Passwords Don't Match");
            } else {
              confirm_password.setCustomValidity('');
            }
          }

          newPassword.onchange = validateNewPassword;
          confirm_password.onkeyup = validateNewPassword;
        </script>
    </body>
</html>

