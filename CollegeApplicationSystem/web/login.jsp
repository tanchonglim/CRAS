<%-- 
    Document   : login
    Created on : Jan 8, 2021, 8:43:20 PM
    Author     : Tan Chong Lim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
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
                  <li class="nav-item ">
                    <a class="nav-link" href="index.jsp">Home </a>
                  </li>
               </ul>

               <div class="form-inline mt-2 mt-md-0">
                   <a class="btn btn-success my-2 my-sm-0"  href="login.jsp"> Login </a>&nbsp; &nbsp;
                  <a class="btn btn-outline-success my-2 my-sm-0" t href="register.jsp">Register</a>
               </div>
            </div>
         </div>
      </nav>     
        <main role="main" class="container">
            <div style='height: 2rem;'></div>
            
            <c:if test="${param.message != null}"> 
                <div class="alert alert-danger" role="alert"> ${param.message} </div>
            </c:if>
 
             <c:if test="${param.success != null}"> 
                <div class="alert alert-success" role="alert"> ${param.success} </div>
            </c:if>
                
            <div style='height: 1rem;'></div>
            
            <div class='row'>
                <div class="col-md-2"> </div>
                 <div class="col-md-8">
                     
                    <div class="card shadow">
                       <div class="card-body">
                          <h2>Demo Admin Credential</h2>
                          <p> Login: admin </p>  
                          <p> Password: admin </p>
                       </div>
                    </div>

                 </div>
                 <div class="col-md-2"></div>
            </div>
            
            <div style='height: 2rem;'></div>
            
             
            <div class='row'>
                <div class="col-md-2"> </div>
                 <div class="col-md-8">
                     
                    <div class="card shadow">
                       <div class="card-body">
                          <h2>Login</h2>
                          <form method="POST" action="StudentLoginServlet" >
                             <div class="form-group">
                               <label for="login">Email Address / Username</label>
                               <input type="text" class="form-control" name="login" id="login" >
                             </div>
                             <div class="form-group">
                               <label for="password">Password</label>
                               <input type="password" class="form-control" name="password" id="password">
                             </div>
                             <div class="form-group form-check">
                               <input type="checkbox" class="form-check-input" name="keepLoggedIn" id="keepLoggedIn">
                               <label class="form-check-label" for="keepLoggedIn">Keep me logged in</label>
                             </div>
                             <button type="submit" class="btn btn-primary">Submit</button>
                          </form>                        
                       </div>
                    </div>

                 </div>
                 <div class="col-md-2"></div>
            </div>
           
        </main>

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>
