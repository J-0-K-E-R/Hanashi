<%-- 
    Document   : index
    Created on : 8 Mar, 2019, 12:12:24 PM
    Author     : Joker
--%>
    
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
            
        <script>
            
            function onIndexPageLoad() {
                $(document).ready(
                        function() {
                            if(<%=session.getAttribute("isLoggedIn")%>) {
                                $("#userQuestion").show();
                        $("#guestQuestion").hide();
                    }
                    else {
                        
                        $("#guestQuestion").show();
                        $("#userQuestion").hide();                
                    }
                });
            }
        </script>
            
    </head>
    
    <body onload="onIndexPageLoad()">
        
        <% 
            if(session.getAttribute("threads") == null) {
                response.sendRedirect("/Hanashi/FetchAllThreads");
            }
        %>
        
        
        <div id="all-threads-container">
            ${threads}
        </div>
        
    </body>
</html>