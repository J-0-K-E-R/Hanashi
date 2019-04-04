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
                }
                else {
                    FollowersDAO fd = new FollowersDAO();
                    session.setAttribute("isFollowing", fd.isFollowing(user.getUsername(), proUser.getUsername()));
                }
                

            }
            

        %>

        
        <script>
            
//            check if user is guest and if not, then is he following the profile user or not
            function pageLoader() {
                $(document).ready(
                function() {
                    if(<%=session.getAttribute("isFollowing")%> === null) {
                        $("#UserFollow").hide();
                        $("#GuestFollow").show();
                        $("#Unfollow").hide();
            }
            else if(<%=session.getAttribute("isFollowing")%> === true) {
                $("#UserFollow").hide();
                $("#GuestFollow").hide();
                $("#Unfollow").show();
            }
            else {
                $("#UserFollow").show();
                $("#GuestFollow").hide();
                $("#Unfollow").hide();
            }
        });
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
                    <div id="UserFollow" hidden>
                        <a  class= "btn btn-default" href="/Hanashi/FollowUser" > Follow </a>
                    </div>
                        
                    <div id="GuestFollow" hidden>
                        <a  class= "btn btn-default" href="/Hanashi/loginpage"> Follow </a>
                    </div>
                        
                    <div id="Unfollow" hidden>
                        <a  class= "btn btn-default" href="/Hanashi/UnfollowUser"> Unfollow </a>
                    </div>
                    
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
