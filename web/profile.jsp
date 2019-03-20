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

        %>
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
            
            <a class= "btn btn-default" href="/Hanashi/FollowUser"> Follow </a>
            
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
