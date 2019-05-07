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
        <%! String heading;%>
        <%
            String query;
            String username;
            
            ArrayList<pojos.User> usersList;
            dao.FollowersDAO fd = new dao.FollowersDAO();
            
            query = request.getParameter("query");
            username = request.getParameter("username");
            
            query = query == null ? "": query;
            
            if(query.equals("followers")) {
                usersList = fd.getFollowers(username);
                heading = username + "'s Followers ("+usersList.size()+")";
            }
            else if(query.equals("following")) {
                usersList = fd.getFollowing(username);
                heading = "Users " + username + " is Following ("+ usersList.size() + ")";
            }
            else {
                dao.UserDAO ud = new dao.UserDAO();
                usersList = ud.fetchUserList();
                heading = "Users";
            }
            session.setAttribute("usersList", usersList);
        %>
        <div id="main" class="main">
        <div id="users-list-wrapper">
            <h2> <%=heading%> </h2>
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
