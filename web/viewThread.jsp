<%-- 
    Document   : viewThread
    Created on : 23 Mar, 2019, 1:38:59 PM
    Author     : robogod
--%>

<%@page import="utilities.ThreadsService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="pojos.Thread"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/header.jsp" %>
    </head>
    <body>
        <% 
            String uri = request.getRequestURI();
            int threadID = -1;
            String title = "";
            try {
                threadID = Integer.parseInt(uri.split("/")[3]);
                title = uri.split("/")[4];
            }
            catch(Exception ex) {
                System.out.println(ex.getMessage());
            }
            
            Thread thread = (Thread)session.getAttribute("currentThread");
            if(thread == null || thread.getThreadID() != threadID) {
                
                request.setAttribute("threadID", threadID);
                RequestDispatcher rd = request.getRequestDispatcher("/FetchThread");
                rd.forward(request, response);
            }
            else {
                String requiredTitle = ThreadsService.titleToURL(thread.getTitle());
                if(!title.equals(requiredTitle))
                    response.sendRedirect("/Hanashi/threads/"+threadID+"/"+requiredTitle);
            }
        %>
        
        
        <h3>${currentThread.getTitle()}
        </h3>
        <div>
            ${currentThread.getPost()}
        </div>
    </body>
</html>
