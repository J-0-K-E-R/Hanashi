<%-- 
    Document   : SignUp
    Created on : 10 Mar, 2019, 4:30:11 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="header.jsp"%>
    </head>
    <body>
        <form action="/Hanashi/SignUp?returnto=<%= session.getAttribute("currentURI") %>" method="post">
            <input type="text" name="Username" placeholder="Username" required><br>
            <input type="text" name="Email" placeholder="Email" required><br>
            <input type="password" name="Password" placeholder="Password" required><br>
            <input type="password"  name="cPassword" placeholder="Confirm Password" required><br>
            <input type="submit" value="Sign Up">
        </form>
        ${errorMessage}
    </body>
</html>