<%-- 
    Document   : profile
    Created on : 14 Mar, 2019, 2:55:56 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="header.jsp"%>
    </head>
    <body>
        <%@include file="LoggedInNavbar.jsp" %>
        <form>
            <div>
                picture
            </div>
            <div>
                Username ${user.getUsername()}
            </div>
            <div>
                Points ${user.getPoints()}
            </div>
            <form>
                <input type="submit" value="Follow">
            </form>
            <div>
                Followers ${user.getFollowersCount()}
            </div>
            <div>
                Following ${user.getFollowingCount()}
            </div>
            <div>
                Threads
            </div>
        <form>
    </body>
</html>
