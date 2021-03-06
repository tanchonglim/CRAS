<%-- 
    Document   : adminViewRoom
    Created on : Jan 12, 2021, 11:20:16 PM
    Author     : Ong Shi Bing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
        <title>Admin View Room</title>
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
            <nav aria-label="breadcrumb">
               <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="AdminSelectAllCollegeServlet">View College</a></li>
                  <li class="breadcrumb-item active" aria-current="page">View Room</li>
               </ol>
            </nav>
            
            <c:if test="${param.message != null}"> 
                <div class="alert alert-danger" role="alert"> ${param.message} </div>
            </c:if>
 
             <c:if test="${param.success != null}"> 
                <div class="alert alert-success" role="alert"> ${param.success} </div>
            </c:if>
            
            <div class="card">
               <div class="container px-5 pt-5">
                   <h3>Room List for <c:out value="${sessionScope.collegeName}"/></h3>
                    <table class="table table-striped">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>No.</th>
                            <th>Room Name</th>
                            <th>Added Date</th>
                            <th>Room Type</th>
                            <th>Activation</th>
                            <th>Capacity</th>
                            <th>Occupied</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <c:if test="${empty requestScope.roomList}"><tr>
                            <td colspan="8">No Room Inserted</td>
                        </tr>
                        </c:if>
                        
                        <c:forEach items="${requestScope.roomList}" var="room" varStatus="loop">
                        <tr>
                            <td><c:out value="${loop.count}" /></td>
                            <td><c:out value="${room.roomName}" /></td>
                            <td><fmt:formatDate value="${room.addedDate}" pattern="dd-MM-yyyy" /></td>
                            <td><c:out value="${room.roomType}" /></td>
                            <td>
                            <c:if test="${room.activated == 1}">
                                    Activated
                            </c:if>
                            <c:if test="${room.activated == 0}">
                                    Deactivated
                            </c:if>
                            </td>
                            <td><c:out value="${room.capacity}" /></td>
                            <td><c:out value="${room.occupied}" /></td>
                            <td>
                            <a href="AdminSelectRoomByRoomIDServlet?rid=<c:out value="${room.roomID}"/>&cid=<c:out value="${room.collegeID}"/>" class="btn btn-primary btn-sm">Update</a>
                            <a href="AdminDeleteRoomServlet?rid=<c:out value="${room.roomID}"/>&cid=<c:out value="${room.collegeID}"/>" onclick="return confirm('Are you sure you want to delete?')" class="btn btn-danger btn-sm">Delete</a>
                             <a href="AdminChangeRoomActivationServlet?rid=<c:out value="${room.roomID}"/>&cid=<c:out value="${room.collegeID}"/>&activated=<c:out value="${room.activated}"/>" class="btn btn-warning btn-sm">
                                <c:if test="${room.activated == 0}">
                                    Activate
                                </c:if>
                                <c:if test="${room.activated == 1}">
                                        Deactivate
                                </c:if>
                             </a>
                           
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                           
                <div class="col text-center" style='padding-bottom: 20px;'>
                  <button class="btn btn-dark" onclick="document.location='adminInsertRoom.jsp?cid=<c:out value="${param.cid}"/>'" class="btn btn-primary align-content-center">New Room</button>
                </div>
                </div>  

            </div>  
           
        </main>

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>
