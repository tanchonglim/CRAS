<%-- 
    Document   : adminViewRoom
    Created on : Jan 12, 2021, 11:20:16 PM
    Author     : Ong Shi Bing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
        
        <sql:setDataSource
        var="collegeApplicationData"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost/college_application?allowMultiQueries=true"
        user="root" password=""
    />
        <sql:query dataSource="${collegeApplicationData}" var="listRoom">
            SELECT * from room where collegeID=?;
            <sql:param value="${param.cid}" />
        </sql:query>
        
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
         <div class="container">
            <a class="navbar-brand" href="#">CRAS </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarCollapse">

               <ul class="navbar-nav mr-auto">
                  <li class="nav-item ">
                    <a class="nav-link active" href="adminHome.jsp">Home </a>
                  </li>
                  <li>
                     <a class="nav-link active" href="adminViewCollege.jsp">College </a>
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
                  <li class="breadcrumb-item"><a href="adminViewCollege.jsp">View College</a></li>
                  <li class="breadcrumb-item active" aria-current="page">View Room</li>
               </ol>
            </nav>
            <div class="card">
               <div class="container px-5 pt-5">
                           <h3>View Room List</h3>
                    <table class="table table-striped">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>No.</th>
                            <th>Room Name</th>
                            <th>Added Date</th>
                            <th>Room Type</th>
                            <th>Capacity</th>
                            <th>Occupied</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <c:set var="i" value="${1}"/>
                        <c:forEach items="${listRoom.rows}" var="room">
                        <tr>
                            <td><c:out value="${i}" /></td>
                            <td><c:out value="${room.roomName}" /></td>
                            <td><fmt:formatDate value="${room.addedDate}" pattern="dd-MM-yyyy" /></td>
                            <td><c:out value="${room.roomType}" /></td>
                            <td><c:out value="${room.capacity}" /></td>
                            <td><c:out value="${room.occupied}" /></td>
                            <td><a href="adminEditRoom.jsp?rid=<c:out value="${room.roomID}"/>&cid=<c:out value="${room.collegeID}"/>">Update</a><br/><a href="AdminDeleteRoomServlet?rid=<c:out value="${room.roomID}"/>&cid=<c:out value="${room.collegeID}"/>">Delete</a></td>
                        </tr>
                        <c:set var="i" value="${i+1}"/>
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
