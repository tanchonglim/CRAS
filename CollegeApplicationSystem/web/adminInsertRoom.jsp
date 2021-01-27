<%-- 
    Document   : adminInsertRoom
    Created on : Jan 12, 2021, 12:45:00 AM
    Author     : Ong Shi Bing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="bean.User" %>

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
        <title>Admin Insert Room</title>
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
                     <a class="nav-link active" href="AdminSelectAllCollegeServlet">College </a>
                  </li>
                  <li>
                     <a class="nav-link" href="AdminSelectAllApplicationServlet">Application</a>
                  </li>
               </ul>
                
                <div class="form-inline mt-2 mt-md-0">
                   <a class="btn btn-danger my-2 my-sm-0"  href="LogoutServlet"> Logout </a>
               </div>

            </div>
         </div>
      </nav>
        
        <main role="main" class="container">
            <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="AdminSelectAllCollegeServlet">View College</a></li>
                  <li class="breadcrumb-item"><a href="AdminSelectRoomByIDServlet?cid=<c:out value="${param.cid}"/>">View Room</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Insert Room</li>
               </ol>
            <div class="card">
               <div class="container pt-5">
                   
                   <div class="row justify-content-md-center">
                       <div class="col col-md-6">
                           <h3>Insert Room</h3>
                        <form action="AdminInsertRoomServlet" method="POST">
                        <div class="form-group">
                            <label>Room Name</label>
                            <input type="text" class="form-control" name="roomName" id="roomName" required>
                         </div>
                         <div class="form-group">
                            <label>College ID</label>
                            <input type="text" class="form-control" name="collegeID" id="collegeID" readonly value="<c:out value="${param.cid}" />" required>
                         </div>
                         <div class="form-group">
                            <label>Room Type</label>
                            <select name="roomType" id="roomType" onChange="OnSelectedIndexChange()" required>
                                <option disabled selected value> -- select an option -- </option>
                                <option value="Double">Double</option>
                                <option value="Single without Toilet">Single without Toilet</option>
                                <option value="Single with Toilet">Single with Toilet</option>
                            </select>
                         </div>
                         <div class="form-group">
                            <label>Capacity</label>
                            <input type="number" class="form-control" name="capacity" id="capacity" readonly>
                         </div>
                      <div class="col text-center" style='padding-bottom: 20px;'>
                          <button type="submit" class="btn btn-dark align-content-center">Insert</button>
                      </div>
                      </form>
                        </div>  
                    </div>
               </div>
            </div>  
           
        </main>
        <script>
            function OnSelectedIndexChange()
        {
        if (document.getElementById('roomType').value === "Double"){
            document.getElementById('capacity').value = 2;
        }
        else if (document.getElementById('roomType').value === "Single without Toilet"||document.getElementById('roomType').value === "Single with Toilet"){
            document.getElementById('capacity').value = 1;
        }
        }
        </script>
      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>

