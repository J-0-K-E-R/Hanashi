<%-- 
    Document   : index
    Created on : 8 Mar, 2019, 12:12:24 PM
    Author     : Joker
--%>
    
<%@page import="utilities.DateService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        
        <% 
            if(session.getAttribute("threads") == null) {
                request.getRequestDispatcher("/FetchAllThreads").forward(request, response);
            }
        %>
        
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
        
        <div id="main" class="main">

        
        <div id="all-threads-container">
            <div id="sortby" class="nav ">
                <a href="#" class="btn btn-default btn-active"> Time </a>
                <a href="#" class="btn btn-default"> Relevance </a>
                <a href="#" class="btn btn-default"> Popularity </a>
            </div>
            <%
                for(pojos.Thread thread: (ArrayList<pojos.Thread>)session.getAttribute("threads")) {
            %>
            <div id='thread-container'>
                <div id='votes'> Votes: <%= thread.getVotes() %></div>
                <div id='thread-title'> <a href='/Hanashi/threads/<%= thread.getThreadID() %>'><%= thread.getTitle() %></a></div>
                <div id='timestamp'><%= DateService.relativeDate(thread.getTimestampModified()) %></div>
            </div>
            <% } %>
        </div>
        </div>
        
    </body>
</html>