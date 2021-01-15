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
        <link href="css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <sql:setDataSource
        var="collegeApplicationData"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost/college_application?allowMultiQueries=true"
        user="root" password=""
    />
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
                   <h1 class="display-6">Welcome <jsp:getProperty name="user" property="username" /></h1>                 
                  <p>
                    <!-- <a class="btn btn-primary" href="#" role="button">Apply Now &raquo;</a> -->
                  </p>
                  <br/><br/>
                  <h3 class="display-6">Select a College </h3>
                <table class="table-light table-bordered">
                    <thead class="table-primary text-center">
                        <tr>                            
                            <th>College Name</th>
                            <th>Space left</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody class="table-secondary text-center">
                        <c:forEach items="${collegeList}" var="college">
                        <tr>                            
                            <td><c:out value="${college.getCollegeName()}" /></td>
                            <td><c:out value="${college.getTotalAvailable()}" /></td>                            
                            <td><a href="StudentApplyCollegePageServlet?cid=<c:out value="${college.getCollegeID()}" />">Select</a></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
               </div>
            </div>  
           
        </main>
    </body>
</html>
