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
        
        
        <div id="main" class="main">

        
        <div id="all-threads-container">
            <div id="sortby" class="nav ">
                <a href="#" class="btn btn-default btn-active"> Time </a>
                <a href="#" class="btn btn-default"> Relevance </a>
                <a href="#" class="btn btn-default"> Popularity </a>
            </div>
            ${threads}
        </div>
        </div>
        
    </body>
</html>