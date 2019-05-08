<%-- 
    Document   : index
    Created on : 8 Mar, 2019, 12:12:24 PM
    Author     : Joker
--%>
    
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
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
            String query;
            try {
                query = request.getQueryString().split("=")[1].trim();
                if(!query.equals("Votes") && !query.equals("Timestamp_Modified") && !query.equals("Relevance")) {
                    System.out.println("Log ::::: Unknown sort by +"+query);
                    query="";
                }
                else {
                    System.out.println("Log :::: sort by " + query);
                }
            } catch(Exception e) {
                query="";
            }
            
            
            ArrayList<pojos.Thread> threadsList;
            if(query.equals("") || query.equals("Relevance")) {
                if(isLoggedIn) {
                    threadsList = td.fetchRelevantThreads(user.getUsername());
                    
                    if(threadsList.size() < 5 && query.equals(""))
                        threadsList = td.fetchAllThreads();
                    
                } else {
                    threadsList = td.fetchAllThreads();
                }
            }
            else
                threadsList = td.fetchAllThreads(query);
            session.setAttribute("threads", threadsList);
        %>

    </head>
    
    <body>
        
        <div id="main" class="main">

        
        <div id="all-threads-container">
            <div id="sortby">
                <div class="btn-group pull-right">
                    <% 
                        if(isLoggedIn) { 
                    %>
                        <a href="/Hanashi/index.jsp?sortby=Relevance" class="btn btn-primary btn-active"> Relevance </a>
                    <%
                        }
                    %>
                    <a href="/Hanashi/index.jsp?sortby=Timestamp_Modified" class="btn btn-primary"> Newest </a>
                    <a href="/Hanashi/index.jsp?sortby=Votes" class="btn btn-primary"> Popular </a>
                </div>
            </div>
            <%
                for(pojos.Thread thread: (ArrayList<pojos.Thread>)session.getAttribute("threads")) {
            %>
            <div id='thread-container'>
                <div id='thread-title'><div class="votes">Votes: <%= thread.getVotes() %></div>
                    <div class="vDivider"></div>
                    <a href='/Hanashi/threads/<%= thread.getThreadID() %>'><%= thread.getTitle() %></a>
                </div>
                <div id="username" class="username"><%= DateService.relativeDate(thread.getTimestampModified()) %> by <a href='/Hanashi/users/<%= thread.getUsername()%>'><%= thread.getUsername()%></a> </div>
            </div>
            <hr class="divider">
            <% } %>
        </div>
        </div>
        
    </body>
</html>