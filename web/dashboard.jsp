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
        
        <script>
            function selectButton() {
                var targetDiv = (window.location.href).split("#")[1];
                if(targetDiv !== "") {
                    $('.btn-dashboard').removeClass('btn-dashboard-selected');
                    $('a[href^="#'+targetDiv+'"]').addClass("btn-dashboard-selected");
                }
            }
            
            
            $(document).ready(function() {
                selectButton();
            });
            
            $(window).on('hashchange', function(e){
                selectButton();
            });
        </script> 
        
    </head>
    <body>
        <div id="main" class="main">
            <h1> Welcome To Dashboard </h1>
            <div id="dashboard-container">
                <div class="dashboard-buttons">
                    <a class="btn-dashboard" href="#notifications" > <span> Notifications </span></a>
                    <a class="btn-dashboard" href="#reported-threads"> <span> Reported Threads </span></a>
                    <a class="btn-dashboard" href="#reported-posts"> <span> Reported Posts </span></a>
                    <a class="btn-dashboard" href="#reported-users"> <span> Reported Users </span></a>
                </div>
                
                <div id="dashboard-content">
                    
                    <div id="notifications" class="dashboard-content-item">
                        Notifications
                    </div>
                    
                    <div id="reported-threads"  class="dashboard-content-item">
                        Reported Threads
                    </div>
                    
                    <div id="reported-posts"  class="dashboard-content-item">
                        Reported Posts
                    </div>
                    
                    <div id="reported-users"  class="dashboard-content-item">
                        Reported Users
                    </div>
                </div>
                
            </div>
        </div>
    </body>
</html>
