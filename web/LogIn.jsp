<%-- 
    Document   : SignIn
    Created on : 10 Mar, 2019, 3:15:12 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title id="title">Hanashi</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>
        <form action="LogIn" method="post">
            <input type="text" name="Username" placeholder="Username" required>
            <input type="password" name="Password" placeholder="Password" required>
            <input type="submit" value="Log In">
        </form>
    </body>
</html>