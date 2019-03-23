<%-- 
    Document   : SignIn
    Created on : 10 Mar, 2019, 3:15:12 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
    </head>
    <body>
        <form action="/Hanashi/Login?returnto=<%= session.getAttribute("currentURI") %>" method="post">
            <h3>Login</h3> <br>
            <input type="text" name="Username" placeholder="Username" required> <br>
            <input type="password" name="Password" placeholder="Password" required> <br>
            <input type="submit" class="btn btn-success" value="Login">
        </form>
        ${errorMessage}
    </body>
</html>