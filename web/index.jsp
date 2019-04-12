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
            dao.ThreadDAO td = new dao.ThreadDAO();
            ArrayList<pojos.Thread> threadsList = td.fetchAllThreads();
            
            session.setAttribute("threads", threadsList);
        %>

    </head>
    
    <body>
        
        <div id="main" class="main">

        
        <div id="all-threads-container">
            <div id="sortby" class="nav ">
                <a href="#" class="btn btn-default btn-active"> Newest </a>
                <a href="#" class="btn btn-default"> Popular </a>
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