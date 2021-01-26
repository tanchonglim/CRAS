<%-- 
    Document   : adminViewApplicationHistory
    Created on : Jan 21, 2021, 11:03:57 AM
    Author     : Wen Jie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.ArrayList" %>



<c:if test="${sessionScope.user == null}">
    <c:redirect url="/notAuthorized.jsp" />   
</c:if>

<c:if test="${!sessionScope.user.getUserType().equals('admin')}">
    <c:redirect url="/notAuthorized.jsp" />   
</c:if>

<jsp:useBean id="user" class="bean.User" scope="session" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <title>Admin Application History</title>
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
                    <a class="nav-link" href="adminHome.jsp">Home </a>
                  </li>
                   <li>
                     <a class="nav-link" href="AdminSelectAllCollegeServlet">College </a>
                  </li>
                  <li>
                     <a class="nav-link active" href="AdminSelectAllApplicationServlet">Application</a>
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
                  <li class="breadcrumb-item"><a href="adminHome.jsp">Home</a></li>
                  <li class="breadcrumb-item"><a href="AdminSelectAllApplicationServlet">View Applications</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Application History</li>
               </ol>
            </nav>
            <div class="card">
               <div class="container px-5 pt-5">
                           <h3>Application History</h3>
                          
                           <c:choose>
                               <c:when test="${requestScope.applicationList.isEmpty()}">
                                   
                               </c:when>
                               <c:otherwise>
                <table class="table table-striped">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>No.</th>
                            <th>Application Date</th>
                            <th>Processed Date</th>
                            <th>Student Name</th>
                            <th>College</th>
                            <th>Room</th>
                            <th>Type</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <c:set var="i" value="${1}"/>
                        <c:forEach items="${requestScope.applicationList}" var="application" varStatus="loop">
                        <tr>
                            <td><c:out value="${i}" /></td>
                            <td><fmt:formatDate value="${application.applicationDate}" pattern="dd-MM-yyyy hh:mm:ss" /></td>
                            <td><fmt:formatDate value="${application.processedDate}" pattern="dd-MM-yyyy hh:mm:ss" /></td>
                            <td><c:out value="${application.studentname}" /></td>
                            <td><c:out value="${application.collegename}" /></td>
                            <td><c:out value="${application.roomname}" /></td>
                            <td><c:out value="${application.roomtype}" /></td>
                            <td><c:out value="${application.status}" /></td>
                        </tr>
                        <c:set var="i" value="${i+1}"/>
                        </c:forEach>
                    </tbody>
                </table>
                               </c:otherwise>
                           </c:choose>
                                                    <br/>
               </div>
            </div>  
        </main>

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>

