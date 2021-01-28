<%-- 
    Document   : index
    Created on : Jan 8, 2021, 8:43:20 PM
    Author     : Tan Chong Lim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CRAS</title>
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
   
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
         <div class="container">
            <a class="navbar-brand" href="index.jsp">CRAS </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarCollapse">

               <ul class="navbar-nav mr-auto">
                  <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Home </a>
                  </li>
               </ul>

               <form class="form-inline mt-2 mt-md-0">
                   <a class="btn btn-success my-2 my-sm-0"  href="login.jsp"> Login </a>&nbsp; &nbsp;
                  <a class="btn btn-outline-success my-2 my-sm-0" t href="register.jsp">Register</a>
               </form>
            </div>
         </div>
      </nav>     
        
        
        
        
        <main role="main" class="container">
            <c:if test="${param.success != null}"> 
                <div class="alert alert-success" role="alert"> ${param.success} </div>
            </c:if> 
            
            <div class="jumbotron">
            <div class="container">
               <h1 class="display-3">Welcome to CRAS </h1>
               <h3>(College Room Application System)</h3>
               <br>
               <p>
                   UTM provides 14,578 accommodation at 10 residential colleges in Johor Bahru campus.
               </p>
               <p>
                  Login now to view and apply rooms offered by collages around the campus with room types ranging from single with bathroom, single room and double room.
               </p>
               <p>
                  <a class="btn btn-primary" target="_blank" href="http://engineering.utm.my/biomedical/wp-content/uploads/sites/14/2017/03/Circular-College-Version-BI-20172018-1.pdf" role="button">Learn more &raquo;</a>
               </p>
            </div>
         </div>       
        </main>
    </body>
</html>
