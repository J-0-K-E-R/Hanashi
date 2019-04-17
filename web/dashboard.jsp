<%-- 
    Document   : dashboard
    Created on : 17 Apr, 2019, 1:37:31 PM
    Author     : robogod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        
        <%
            if(!isLoggedIn || user.getPrivilege() > 2) {
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        %>
        
        
    </head>
    <body>
        <div id="main" class="main">
            <h1> Welcome To Dashboard </h1>
        </div>
    </body>
</html>
