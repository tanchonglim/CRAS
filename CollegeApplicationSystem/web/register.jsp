<%-- 
    Document   : register
    Created on : Jan 8, 2021, 8:43:20 PM
    Author     : Tan Chong Lim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
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
        <div style='height: 8rem;'></div>
        <main role="main" class="container">
            <div class="row">
                <div class="col-md-5">
                    <div class="jumbotron">
                        <div class="container">
                          <h1 class="display-3">Hello, world!</h1>
                          <p>
                             This system is only for student who has registered with our University.
                          </p>
                          <p>
                             <a class="btn btn-primary " href="#" role="button">Learn more &raquo;</a>
                          </p>
                       </div>
                     </div>
                </div>
                
                <div class="col-md-7">
                    <div class="card shadow">
                        <div class="card-body">
                           <h2>Resigtration Form</h2>
                           <p>Registration open for student only</p>

                           <form action="StudentRegistrationServlet" method="POST">
                              <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input type="email" class="form-control" id="email" name="email" required="true">
                                
                              </div>
                               <div class="form-group">
                                <label for="exampleInputEmail1">Username</label>
                                <input type="text" class="form-control" id="username" name="username" required="true">
                              </div>
                              <div class="form-group">
                                <label for="exampleInputPassword1">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required="true">
                              </div>
                              <div class="form-group">
                                <label for="exampleInputPassword1">Password Confirmation</label>
                                <input type="password" class="form-control" id="passwordConfirm" required="true">
                              </div>
                               
                              <div class="form-group">
                                <label for="exampleInputPassword1">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" aria-describedby="fullNameHelp" required="true">
                                <small id="fullNameHelp" class="form-text text-muted">Full name as per IC/passport </small>
                              </div>
                              
                               
                              <div class="form-group">
                                <label for="exampleInputPassword1">Matric Number</label>
                                <input type="text" class="form-control" id="matricNo" name="matricNo" required="true">
                                <small id="matricNo" class="form-text text-muted">Please get this from your school if you don't have one. </small>
                              </div>
                              
                              
                            
                              <button type="submit" class="btn btn-primary">Register</button>
                           </form>                        
                        </div>
                    </div>
                </div>
            
            </div>    
        </main>
        

      
      <script src="js/jquery-3.5.1.min.js"></script>
      <script src="js/popper.min.js"></script>      
      <script src="js/bootstrap.min.js"></script>
      
        <script>
            var password = document.getElementById("password")
            , confirm_password = document.getElementById("passwordConfirm");

          function validatePassword(){
            if(password.value != confirm_password.value) {
              confirm_password.setCustomValidity("Passwords Don't Match");
            } else {
              confirm_password.setCustomValidity('');
            }
          }

          password.onchange = validatePassword;
          confirm_password.onkeyup = validatePassword;
        </script>
    </body>
</html>
