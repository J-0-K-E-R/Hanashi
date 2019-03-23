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
            else {
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
        
        <div>
            <div>
                picture
            </div>
            <div>
                Username: ${profileUser.getUsername()}
            </div>
            <div>
                Points: ${profileUser.getPoints()}
            </div>
            
            <div>
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
            
            <div>
                Followers ${profileUser.getFollowersCount()}
            </div>
            <div>
                Following ${profileUser.getFollowingCount()}
            </div>
            <div>
                Threads
            </div>
        </div>
    </body>
</html>
