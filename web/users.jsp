<%-- 
    Document   : users
    Created on : 16 Mar, 2019, 1:03:43 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="header.jsp"%>
    </head>
    <body>
        <% 
            
            String ut = (String)session.getAttribute("userTable");
            if(ut == null) {
                RequestDispatcher rd = request.getRequestDispatcher("/UsersList");
                rd.forward(request, response);
            }

        %>
        <div id="table-wrapper">
            <div id="table-scroll">
                ${userTable}
            </div>
        </div>
    </body>
</html>
