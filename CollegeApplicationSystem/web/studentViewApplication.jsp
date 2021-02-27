<%-- 
    Document   : studentViewApplication
    Created on : Jan 14, 2021, 3:31:08 PM
    Author     : Yeoh Kai Xiang
--%>

<%@page import="bean.Application"%>
<%@page import="bean.Room"%>
<%@page import="bean.College"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="bean.Student" %>
<%@ page import="jdbc.JDBCUtility" %>
<%@ page import="javax.servlet.http.HttpSession;" %>

<jsp:useBean id="user" class="bean.User" scope="session" />
<jsp:useBean id="student" class="bean.Student" scope="session" />

<c:if test="${sessionScope.user == null || sessionScope.student == null }">
    <c:redirect url="/notAuthorized.jsp" />   
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <title>View Application</title>
        <link href="css/navbar-top-fixed.css" rel="stylesheet"> 
        <style>
            table{
                width: 100%
            }
        </style>
    </head>
    <body>
        <% 
            ArrayList<College> collegeList = (ArrayList<College>)request.getAttribute("college");
            pageContext.setAttribute("collegeList", collegeList);
            
            ArrayList<Room> roomList = (ArrayList<Room>)request.getAttribute("room");
            pageContext.setAttribute("roomList", roomList);
            
            ArrayList<Application> applicationList = (ArrayList<Application>)request.getAttribute("application");
            pageContext.setAttribute("applicationList", applicationList);
            
       
        %>
        
            
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
                     <a class="nav-link active" href="StudentViewApplicationServlet">College Application</a>
                  </li>
                  <li>
                     <a class="nav-link" href="studentProfile.jsp">Profile </a>
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
                  <li class="breadcrumb-item active" aria-current="page">College Application</li>
               </ol>
            </nav>
            
            <div class="card">
               <div class="container">
                   <div class="row justify-content-md-center" style="margin:10px">
                       <h3>College Application Record</h3>
                  </div>
                   <c:choose>
                        <c:when test="${applicationList.size() > 0}">
                            <div class="col">
                            <table class="table table-striped">
                            <thead class="thead-dark text-center">
                                <tr>
                                    <th>Application Date</th>
                                    <th>College</th>
                                    <th>Room Name</th>
                                    <th>Room Type</th>
                                    <th>Status</th>
                                    <th>Processed Date</th>                      
                                </tr>
                            </thead>
                            <tbody class="text-center">
                                <% for(int i=0; i<applicationList.size(); i++){ %>
                                    <tr>
                                        <td><fmt:formatDate value="${applicationList.get(i).getApplicationDate()}" pattern="dd-MM-yyyy hh:mm:ss" /></td>                                        
                                        <td><%= collegeList.get(i).getCollegeName() %></td>
                                        <td><%= roomList.get(i).getRoomName() %></td>
                                        <td><%= roomList.get(i).getRoomType() %></td>
                                        <td><%= applicationList.get(i).getStatus() %></td>
                                        <td><fmt:formatDate value="${applicationList.get(i).getProcessedDate()}" pattern="dd-MM-yyyy hh:mm:ss" /></td>
                                    </tr>
                                <% } %>
                            </tbody>
                            </table>
                            </div>
                   </c:when>
                         <c:otherwise>
                            <div class="row justify-content-md-center">No application record</div>
                        </c:otherwise>
                    </c:choose>
                <div class="row justify-content-md-center" style="margin:10px">
                <c:choose>
                    <c:when test="${student.application == 1}">
                        <a class="btn btn-primary disabled" href="studentSelectCollege.jsp" role="button">Apply Now &raquo;</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-primary" href="StudentSelectCollegeServlet" role="button">Apply Now &raquo;</a>
                    </c:otherwise>
                </c:choose>
                </div>
               </div>
            </div>
        </main>
    </body>
</html>
