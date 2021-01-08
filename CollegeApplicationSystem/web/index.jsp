<%-- 
    Document   : index
    Created on : Jan 8, 2021, 8:43:20 PM
    Author     : Tan Chong Lim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
             <div class="jumbotron">
            <div class="container">
               <h1 class="display-3">Welcome to CRAS </h1>
               <p>
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

               </p>
               <p>
                  <a class="btn btn-primary" href="#" role="button">Learn more &raquo;</a>
               </p>
            </div>
         </div>       
        </main>
    </body>
</html>
