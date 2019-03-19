<%-- 
    Document   : SignIn
    Created on : 10 Mar, 2019, 3:15:12 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="header.jsp"%>
    </head>
    <body>
        <form action="/Hanashi/Login" method="post">
            <input type="text" name="Username" placeholder="Username" required>
            <input type="password" name="Password" placeholder="Password" required>
            <input type="submit" value="Log In">
        </form>
        ${errorMessage}
    </body>
</html>