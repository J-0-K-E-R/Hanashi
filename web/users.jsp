<%-- 
    Document   : users
    Created on : 16 Mar, 2019, 1:03:43 PM
    Author     : Joker
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
    </head>
    <body>
        <% 
            
            ArrayList ut = (ArrayList <User>)session.getAttribute("usersList");
            if(ut == null) {
                RequestDispatcher rd = request.getRequestDispatcher("/UsersList");
                rd.forward(request, response);
            }

        %>
        <div id="main" class="main">
        <div id="users-list-wrapper">
            <h4> Users </h4>
            <div id="div-scroll">
                <div id='users-list-container'>
                <%
                    for(User u : (ArrayList<User>)session.getAttribute("usersList")){
                %>
                <div class='user-item'>
                    <div class='user-profile-image'>
                        <a href="/Hanashi/users/<%= u.getUsername()%>"><img src="<%= u.getAvatarPath() %>" class="user-profile-image"></a>
                    </div>
                    <div class='username'>
                        <a href='/Hanashi/users/<%= u.getUsername()%>'><%= u.getUsername()%></a>
                    </div>
                    <div class='user-points'><%= u.getPoints()%></div>
                </div>
                <% } %>
                </div>
            </div>
        </div>
        </div>
    </body>
</html>
