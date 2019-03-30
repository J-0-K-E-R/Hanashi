<%-- 
    Document   : tags
    Created on : 30 Mar, 2019, 6:14:23 PM
    Author     : robogod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
    </head>
    <body>
        <% 
            
            String tagsList = (String)session.getAttribute("tagsList");
            if(tagsList == null) {
                RequestDispatcher rd = request.getRequestDispatcher("/TagsList");
                rd.forward(request, response);
            }

        %>
        <div id="main" class="main">
            <div id="tags-list-wrapper">
            <h3>Tags</h3>
            <div class="grid-container">
                ${tagsList}
            </div>
            </div>
        </div>
    </body>
</html>
