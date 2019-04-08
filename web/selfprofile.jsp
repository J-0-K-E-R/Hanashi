<%-- 
    Document   : selfprofile
    Created on : 4 Apr, 2019, 11:18:17 AM
    Author     : robogod
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="utilities.DateService"%>
<%@page import="dao.FollowersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        
                <!--Check if profile of the current user is fetched or not-->
        <% 
            
            User proUser = (User)session.getAttribute("user");
            if(proUser == null) {
                System.out.println("Log:::::: User not logged in!");
                response.sendRedirect("/Hanashi/index.jsp");
            }
            else {
                System.out.println("Log::::: Current Profile Found");
            }
            

        %>

        
        <script>
            
//            check if user is guest and if not, then is he following the profile user or not
            function pageLoader() {
                
            }
        </script>
        
    </head>
    
    <body onload="pageLoader()">
        
        <div id="main" class="main">
        <div id="user-profile-container">
            
            <div id="top">
                <div class="profile-picture">
                    <a href="/Hanashi/users/${profileUser.getUsername()}">
                        <img src="${profileUser.getAvatarPath()}" class="profile-picture">
                    </a>
                </div>
                <div id="username">
                    ${profileUser.getUsername()}
                </div>
                <div id="points">
                    Points ${profileUser.getPoints()}
                </div>
                
                <div id="followers-following">
                    <a href="#"  class="btn btn-info"> Followers ${profileUser.getFollowersCount()} </a>
                    <a href="#"  class="btn btn-info"> Following ${profileUser.getFollowingCount()} </a>
                </div>
            
                <br style="clear:both;"/>
            </div>
            <div id="user-threads">
                <%
                    for(pojos.Thread thread: (ArrayList<pojos.Thread>)session.getAttribute("userThreads")) {
                %>
                <div id='thread-container'>
                    <div id='votes'> Votes: <%= thread.getVotes() %></div>
                    <div id='thread-title'> <a href='/Hanashi/threads/<%= thread.getThreadID() %>'><%= thread.getTitle() %></a></div>
                    <div id='timestamp'><%= DateService.relativeDate(thread.getTimestampModified()) %></div>
                </div>
                <% } %>
            </div>
        </div>
        </div>
    </body>
</html>