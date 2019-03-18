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
        <form>
            <div>
                picture
            </div>
            <div>
                Username ${profileUser.getUsername()}
            </div>
            <div>
                Points ${profileUser.getPoints()}
            </div>
        </form>
        <form action="FollowUser">
            <input type="submit" value="Follow">
        </form>
        <form>
            <div>
                Followers ${profileUser.getFollowersCount()}
            </div>
            <div>
                Following ${profileUser.getFollowingCount()}
            </div>
            <div>
                Threads
            </div>
        <form>
    </body>
</html>
