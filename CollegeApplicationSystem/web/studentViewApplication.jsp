<%-- 
    Document   : studentViewApplication
    Created on : Jan 14, 2021, 3:31:08 PM
    Author     : Yeoh Kai Xiang
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="bean.Student" %>
<%@ page import="jdbc.JDBCUtility" %>
<%@ page import="javax.servlet.http.HttpSession;" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <title>View Application</title>
        <link href="css/navbar-top-fixed.css" rel="stylesheet"> 
    </head>
    <body>
        <% ResultSet rs = (ResultSet)request.getAttribute("data"); 
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            String date = formatter.format(rs.getDate(2));
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
                   <li class="breadcrumb-item"><a href="studentHome.jsp">Home</a></li>
                  <li class="breadcrumb-item active" aria-current="page">View Application</li>
               </ol>
            </nav>
            
            <div class="card">
               <div class="container">
                   <div class="row justify-content-md-center">
                       <p>College Application Record</p>
                  </div>
                    <table class="table-light table-bordered">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Application Date</th>
                            <th>College</th>
                            <th>Room Name</th>
                            <th>Room Type</th>
                            <th>Status</th>
                            <th>Processed Date</th>                      
                        </tr>
                    </thead>
                    <tbody class="table-secondary text-center">                        
                        <tr>
                            <td><%= date %></td>
                            <td><%= rs.getString(15) %></td>
                            <td><%= rs.getString(8) %></td>
                            <td><%= rs.getString(11) %></td>
                            <td><%= rs.getString(6) %></td>
                            <td><%= rs.getDate(3) %></td>
                        </tr>
                    </tbody>
                </table>
                        
                      
               </div>
            </div>
        </main>
    </body>
</html>
