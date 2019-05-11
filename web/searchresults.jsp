<%-- 
    Document   : searchresults
    Created on : 15 Apr, 2019, 10:45:17 PM
    Author     : robogod
--%>

<%@page import="utilities.DateService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        
        <%! String query;
            
            ArrayList<pojos.Thread> threadsList;
        %>
        <% 
            dao.ThreadDAO td = new dao.ThreadDAO();
            
            query = request.getParameter("query");
            
            threadsList = td.search(query);
            
            session.setAttribute("searchThreads", threadsList);
        %>
        
        <script>
            var srch_field = document.getElementById("query");
            srch_field.value = '<%=query%>';
        </script>

    </head>
    
    <body>
        
        <div id="main" class="main">
            <h2>Search results for "<%=query%>"</h2>
            <h4><%=threadsList.size()%> result(s) found</h4>
            
            <div id="all-threads-container">
                <%
                    for(pojos.Thread thread: (ArrayList<pojos.Thread>)session.getAttribute("searchThreads")) {
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