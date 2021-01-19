<%-- 
    Document   : studentProfile
    Created on : Jan 10, 2021, 8:09:54 PM
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
        <title>Student Home</title>
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
                  <li class="breadcrumb-item active" aria-current="page">Profile</li>
               </ol>
            </nav>
            
            <div class="card">
               <div class="container">
                   <div class="row justify-content-md-center">
                       <div class="col col-md-3" style="padding:20px">
                       <img src="img/${student.imagePath}" class="rounded img-fluid">
                       </div>
                  </div>
                   <dl class="row">
                       <dt class="col-sm-6 text-right">Username</dt>
                        <dd class="col-sm-6"><jsp:getProperty name="user" property="username" /></dd>
                        
                        <dt class="col-sm-6 text-right">Name</dt>
                        <dd class="col-sm-6"><jsp:getProperty name="student" property="name" /></dd>

                        <dt class="col-sm-6 text-right">Matric No.</dt>
                        <dd class="col-sm-6"><jsp:getProperty name="student" property="matricNo" /></dd>

                        <dt class="col-sm-6 text-right">Email address</dt>
                        <dd class="col-sm-6"><jsp:getProperty name="user" property="email" /></dd>
                        
                        <dt class="col-sm-6 text-right">Joined Date</dt>
                        <dd class="col-sm-6"><fmt:formatDate value="${user.addedDate}" pattern="dd-MM-yyyy" /></dd>
                      </dl>
                      <div class="col text-center" style='padding-bottom: 20px;'>
                        <a class="btn btn-primary align-content-center"  href="studentEditProfile.jsp"> Edit Profile </a>
                      </div>
               </div>
            </div>  
           
        </main>

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>
