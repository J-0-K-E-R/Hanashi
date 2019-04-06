<%-- 
    Document   : profile
    Created on : 14 Mar, 2019, 2:55:56 PM
    Author     : Joker
--%>

<%@page import="dao.FollowersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        
        <!--Check if profile of the current user is fetched or not-->
        <%! String followButtonURI; %>
        <% 
            String uri = request.getRequestURI();
            String username = null;
            try {
                username = uri.split("/")[3];              
            }
            catch(Exception ex) {
                System.out.println(ex.getMessage());
            }
            
            User proUser = (User)session.getAttribute("profileUser");
            if(proUser == null || !proUser.getUsername().equals(username)) {
                request.setAttribute("profileUsername", username);
                RequestDispatcher rd = request.getRequestDispatcher("/Profile");
                rd.forward(request, response);
            }
            else if(user != null && user.getUsername().equals(username)) {
                RequestDispatcher rd = request.getRequestDispatcher("/selfprofile.jsp");
                rd.forward(request, response);                
            }
            else {
                System.out.println("Log::::: Profile Found");
                if(session.getAttribute("user") == null ) {
                    session.setAttribute("isFollowing", null);
                    String message= "Please Login to continue";
                    session.setAttribute("errorMessage", message);
                    followButtonURI = "/Hanashi/loginpage";
                }
                else {
                    FollowersDAO fd = new FollowersDAO();
                    boolean isFollowing =  fd.isFollowing(user.getUsername(), proUser.getUsername());
                    
                    if(isFollowing) {
                        followButtonURI = "/Hanashi/UnfollowUser";
                    }
                    else {
                        followButtonURI = "/Hanashi/FollowUser";
                    }
                    
                    session.setAttribute("isFollowing", isFollowing);
                }
                

            }
            

        %>

        
        <script>
            
            //            check if user is guest and if not, then is he following the profile user or not
            function pageLoader() {
                var followbutton = document.getElementById("follow-button-anchor");
                
                if(<%=session.getAttribute("isFollowing")%> === true) 
                    followbutton.innerHTML = "Unfollow";
                else 
                    followbutton.innerHTML = "Follow";
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
                
                <div id="follow-button">
                    <a id="follow-button-anchor" class= "btn btn-default" href="<%=followButtonURI%>" > ... </a>    
                </div>
            
                <br style="clear:both;"/>
            </div>
            <div id="user-threads">
                ${userThreads}
            </div>
        </div>
        </div>
    </body>
</html>
