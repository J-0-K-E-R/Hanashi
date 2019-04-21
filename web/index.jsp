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
                    dao.TagsFollowersDAO tfd = new dao.TagsFollowersDAO();
                    String search_query = tfd.fetchTags(user.getUsername());
                    threadsList = td.search(search_query);
                    // sort by Timestamp_Modified
                    Collections.sort(threadsList, new Comparator<pojos.Thread>() {
                        @Override
                        public int compare(pojos.Thread o1, pojos.Thread o2) {
                            return o1.getTimestampModified().compareTo(o2.getTimestampModified());
                        }
                    }.reversed());
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
            <div id="sortby" class="">
                <% 
                    if(isLoggedIn) { 
                %>
                    <a href="/Hanashi/index.jsp?sortby=Relevance" class="btn btn-default btn-active"> Relevance </a>
                <%
                    }
                %>
                <a href="/Hanashi/index.jsp?sortby=Timestamp_Modified" class="btn btn-default"> Newest </a>
                <a href="/Hanashi/index.jsp?sortby=Votes" class="btn btn-default"> Popular </a>
            </div>
            <%
                for(pojos.Thread thread: (ArrayList<pojos.Thread>)session.getAttribute("threads")) {
            %>
            <div id='thread-container'>
                <div id='votes'> Votes: <%= thread.getVotes() %></div>
                <div id='thread-title'> <a href='/Hanashi/threads/<%= thread.getThreadID() %>'><%= thread.getTitle() %></a></div>
                <div id="username" class="username"><a href='/Hanashi/users/<%= thread.getUsername()%>'><%= thread.getUsername()%></a> </div>
                <div id='timestamp'><%= DateService.relativeDate(thread.getTimestampModified()) %></div>
            </div>
            <% } %>
        </div>
        </div>
        
    </body>
</html>