<%-- 
    Document   : adminViewApplication
    Created on : Jan 13, 2021, 8:59:44 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <title>Admin View Application</title>
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
                  <li class="breadcrumb-item active" aria-current="page">View Applications</li>
               </ol>
            </nav>
            <div class="card">
               <div class="container">
                   
                   <div class="row justify-content-md-center text-center">
                       <div class="col">
                           <h3>View Application List</h3>
                <table class="table table-striped">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>Application ID</th>
                            <th>Application Date</th>
                            <th>Processed Date</th>
                            <th>Student ID</th>
                            <th>Room ID</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <c:forEach items="${requestScope.applicationList}" var="application" varStatus="loop">
                        <tr>
                            <td><c:out value="${application.applicationID}" /></td>
                            <td><c:out value="${application.applicationDate}" /></td>
                            <td><c:out value="${application.processedDate}"/></td>
                            <td><c:out value="${application.studentID}" /></td>
                            <td><c:out value="${application.roomID}" /></td>
                            <td><c:out value="${application.status}" /></td>
                            <td>
                                <form action="AdminUpdateApprovalApplicationServlet" method="POST">
                                  <button name="status" type="submit" value="approved" class="btn btn-outline-dark btn-sm m-1">Approve</button>
                                  <button name="status" type="submit" value="unapproved" class="btn btn-outline-dark btn-sm m-1">Unapprove</button>
                                  <input type="hidden" name="applicationID" value="<c:out value="${application.applicationID}" />">
                                </form>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                           <br/>
                  <br/><br/>
                        </div>  
                    </div>
               </div>
            </div>  
        </main>

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>
