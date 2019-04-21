<%-- 
    Document   : dashboard
    Created on : 17 Apr, 2019, 1:37:31 PM
    Author     : robogod
--%>

<%@page import="java.util.ArrayList"%>
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
            <h3> Welcome To Dashboard </h3>
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
                        <%
                            ArrayList<pojos.ThreadReport> reportedThreadsList = 
                                dao.ReportedThreadsDAO.fetchReportedThreads();
                            dao.ThreadDAO td = new dao.ThreadDAO();
                            
                            for(pojos.ThreadReport report: reportedThreadsList) {
                                pojos.Thread thread = td.fetchThread(report.getThreadID());
                        %>        
                         
                        <div id='thread-container'>
                            <div id='votes'> Votes: <%= thread.getVotes() %></div>
                            
                            <div id="dropdown">
                                <div id='thread-title'> <a href='/Hanashi/threads/<%= thread.getThreadID() %>'><%= thread.getTitle() %></a></div>

                                <div class="report-info">
                                    <div class="reported-by"> Reported By: 
                                        <a href="/Hanashi/users/<%=report.getReportedBy()%>" class="username"> <%=report.getReportedBy()%> </a>
                                    </div>
                                    <div class="reported"> Reported: 
                                        <span class="reported-time"> <%= utilities.DateService.relativeDate(report.getTimestamp()) %> </span> 
                                    </div>
                                    <div class="comment"> Comment: <span class="comment-content"> <%=report.getComment()%> </span> </div>
                                </div>
                            </div>
                            
                            <div id="username" class="username"><a href='/Hanashi/users/<%= thread.getUsername()%>'><%= thread.getUsername()%></a> </div>
                            <div id='timestamp'><%= utilities.DateService.relativeDate(thread.getTimestampModified()) %></div>


                        </div>
                        


                        <%  } %>
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
