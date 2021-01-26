<%-- 
    Document   : studentApplyCollege
    Created on : Jan 13, 2021, 8:43:15 PM
    Author     : Yeoh Kai Xiang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="bean.User" %>
<%@ page import="bean.College" %>
<%@ page import="bean.Room" %>
<%@ page import="java.util.ArrayList" %>

<c:if test="${sessionScope.user == null || sessionScope.student == null }">
    <c:redirect url="/notAuthorized.jsp" />   
</c:if>

<jsp:useBean id="user" class="bean.User" scope="session" />
<jsp:useBean id="student" class="bean.Student" scope="session" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apply College</title>
        <link href="css/navbar-top-fixed.css" rel="stylesheet">
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
            table{
                width: 100%
            }
            .card{
                padding: 3rem 2rem;
            }
        </style>
    </head>
    <body>
       
        <%
            ArrayList<College> collegeList = (ArrayList<College>)request.getAttribute("data");
            pageContext.setAttribute("collegeList", collegeList);
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
                  <li class="breadcrumb-item"><a href="StudentViewApplicationServlet">College Application</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Select College</a></li>
               </ol>
            </nav>
            
            <div class="card" style="margin: 10px">
               <div class="container">
                   <div style="margin: 10px">
                       <h4 class="display-6">Select a College </h4>
                  </div>
                               
                   <table class="table table-striped">
                    <thead class="thead-dark text-center">
                        <tr>                            
                            <th>College Name</th>
                            <th>Space left</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <c:forEach items="${collegeList}" var="college">
                        <tr>                            
                            <td><c:out value="${college.getCollegeName()}" /></td>
                            <td><c:out value="${college.getTotalAvailable()}" /></td>   
                            <c:choose>
                                <c:when test="${college.getTotalAvailable() != 0}">
                                    <td><a class="btn btn-outline-dark btn-sm m-1" role="button" href="StudentApplyCollegePageServlet?cid=<c:out value="${college.getCollegeID()}" />">Select</a></td>
                                </c:when>
                                <c:otherwise>
                                    <td><a class="btn btn-outline-dark btn-sm m-1 disabled" role="button">Select</a></td>
                                </c:otherwise>
                            </c:choose>                            
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
               </div>
            </div>
        </main>
    </body>
</html>
