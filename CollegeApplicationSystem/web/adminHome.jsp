<%-- 
    Document   : adminHome
    Created on : Jan 9, 2021, 5:00:26 PM
    Author     : Tan Chong Lim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="bean.User" %>
<%@ page import="bean.College" %>
<%@ page import="bean.Room" %>
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
        <title>Admin Home</title>
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

    </head>
    <body>
    <sql:setDataSource
        var="collegeApplicationData"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost/college_application?allowMultiQueries=true"
        user="root" password=""
    />
     
    <sql:query var="listCollege"   dataSource="${collegeApplicationData}">
        SELECT * FROM college;
    </sql:query>
        
    <sql:query var="listRoom"   dataSource="${collegeApplicationData}">
        SELECT * FROM room;
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
            
            <div class="jumbotron">
               <div class="container">
                   <h1 class="display-6">Welcome <jsp:getProperty name="user" property="username" /> (admin) </h1>
                  <p>
                      This is admin panel <br>
                  </p>
                  <p>
                    <!-- <a class="btn btn-primary" href="#" role="button">Apply Now &raquo;</a> -->
                  </p>
                  <br/><br/>
                  <h3 class="display-6">Manage College </h3>
                <table class="table-light table-bordered">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>College ID</th>
                            <th>College Name</th>
                            <th>Address</th>
                            <th>Added Date</th>
                            <th>Operation</th>
                            <th>Room</th>
                        </tr>
                    </thead>
                    <tbody class="table-secondary text-center">
                        <c:forEach items="${listCollege.rows}" var="college">
                        <tr>
                            <td><c:out value="${college.collegeID}" /></td>
                            <td><c:out value="${college.collegeName}" /></td>
                            <td><c:out value="${college.address}" /></td>
                            <td><c:out value="${college.addedDate}" /></td>
                            <td><a href="adminEditCollege.jsp?cid=<c:out value="${college.collegeID}"/>">Update</a><br/>
                                <a href="AdminDeleteCollegeServlet?cid=<c:out value="${college.collegeID}"/>">Delete</a>
                            </td>
                            <td><a href="adminViewRoom.jsp?cid=<c:out value="${college.collegeID}"/>">View Room</a></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                  <br/>
                  <button onclick="document.location='adminInsertCollege.jsp'" class="btn btn-primary align-content-center">New College</button>
                  <br/><br/>
               </div>
            </div>  
           
        </main>
        
        
        <!--div class="jumbotron">
            <div class="container">
                <h3 class="display-6">Manage College </h3>
                <table class="table-light table-bordered">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>College ID</th>
                            <th>College Name</th>
                            <th>Address</th>
                            <th>Added Date</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody class="table-secondary text-center">
                        <c:forEach items="${listCollege.rows}" var="college">
                        <tr>
                            <td><c:out value="${college.collegeID}" /></td>
                            <td><c:out value="${college.collegeName}" /></td>
                            <td><c:out value="${college.address}" /></td>
                            <td><c:out value="${college.addedDate}" /></td>
                            <td><a href="adminEditCollege.jsp?cid=<c:out value="${college.collegeID}"/>">Update</a><br/><a href="">Delete</a></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div-->
                  
        <!--div class="jumbotron">
            <div class="container">
                <h3 class="display-6">Manage Room </h3>
                <table class="table-light table-bordered">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Room ID</th>
                            <th>Room Name</th>
                            <th>College ID</th>
                            <th>Added Date</th>
                            <th>Room Type</th>
                            <th>Capacity</th>
                            <th>Occupied</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody class="table-secondary text-center">
                        <c:forEach items="${listRoom.rows}" var="room">
                        <tr>
                            <td><c:out value="${room.roomID}" /></td>
                            <td><c:out value="${room.roomName}" /></td>
                            <td><c:out value="${room.collegeID}" /></td>
                            <td><c:out value="${room.addedDate}" /></td>
                            <td><c:out value="${room.roomType}" /></td>
                            <td><c:out value="${room.capacity}" /></td>
                            <td><c:out value="${room.occupied}" /></td>
                            <td><a href="adminEditRoom.jsp?rid=<c:out value="${room.roomID}"/>">Update</a><br/><a href="">Delete</a></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
        </div>
      </div-->
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>
