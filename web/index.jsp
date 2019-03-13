<%-- 
    Document   : index
    Created on : 8 Mar, 2019, 12:12:24 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Hanashi : Because winter is coming</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script-->
    
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="index.css">
    </head>
    <body>
        <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <!-- Logo -->
            <div class="navbar-header">
                <a href="#" class="navbar-brand">Hanashi</a>
            </div>
            <div>
                <ul class="nav navbar-nav">
                    <li class="active nav-item"><a href="#">Home</a></li>
                    <li class="nav-item"><a href="#">About</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li class="nav-item"><a href="#" data-toggle="popover" title="Hanashi" data-placement="bottom" data-content='<input type="text" placeholder="Username">'><span class="glyphicon glyphicon-log-in"></span> Sign In</a></li>
                    <li class="nav-item"><a href="SignUp.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <script>
        $(document).ready(function(){
            $('[data-toggle="popover"]').popover({container: 'body'}); 
        });
    </script>
    </body>
</html>
<!--<form action="SignIn">
            <input type="text" placeholder="Username">
            <input type="password" placeholder="Password">
            <input type="submit" value="Sign In">
        </form>'-->