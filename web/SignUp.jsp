<%-- 
    Document   : SignUp
    Created on : 10 Mar, 2019, 4:30:11 PM
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
        <form action="signUp" method="post">
            <input type="text" name="Username" placeholder="Username"><br>
            <input type="text" name="Email" placeholder="Email"><br>
            <input type="password" name="Password" placeholder="Password"><br>
            <input type="password"  name="cPassword" placeholder="Confirm Password"><br>
            <input type="submit" value="Sign Up">
        </form>
    </body>
</html>