<%-- 
    Document   : studentHome
    Created on : Jan 9, 2021, 5:00:12 PM
    Author     : Tan Chong Lim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ page import="bean.Student" %>

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
                    <a class="nav-link active" href="studentHome.jsp">Home </a>
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
                  <li class="breadcrumb-item active" aria-current="page">Home</li>
               </ol>
            </nav>
            
            <c:if test="${param.message != null}"> 
                <div class="alert alert-danger" role="alert"> ${param.message} </div>
            </c:if>
 
             <c:if test="${param.success != null}"> 
                <div class="alert alert-success" role="alert"> ${param.success} </div>
            </c:if>
            
            <div class="jumbotron">
               <div class="container">
                   <h1 class="display-6">Welcome <jsp:getProperty name="user" property="username" /> (student) </h1>
                  <p>
                      Are you here for college room application? <br>
                  </p>
                  <p>
                     <c:choose>
                         <c:when test="${student.application == 1}">
                            <a class="btn btn-primary disabled" href="studentSelectCollege.jsp" role="button">Apply Now &raquo;</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-primary" href="StudentSelectCollegeServlet" role="button">Apply Now &raquo;</a>
                        </c:otherwise>
                    </c:choose>
                  </p>
                  <p>
                      <a class="btn btn-primary" href="StudentViewApplicationServlet" role="button">View Application &raquo;</a>
                  </p>
               </div>
            </div>  
        </main>
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>
