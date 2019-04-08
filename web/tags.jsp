<%-- 
    Document   : tags
    Created on : 30 Mar, 2019, 6:14:23 PM
    Author     : robogod
--%>

<%@page import="pojos.Tag"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
    </head>
    <body>
        <% 
            
            ArrayList<Tag> tagsList = (ArrayList<Tag>)session.getAttribute("tagsList");
            if(tagsList == null) {
                RequestDispatcher rd = request.getRequestDispatcher("/TagsList");
                rd.forward(request, response);
            }

        %>
        <div id="main" class="main">
            <div id="tags-list-wrapper">
            <h3>Tags</h3>
            <div class="grid-container">
                <%
                    for(Tag tag: (ArrayList<Tag>)session.getAttribute("tagsList")) {
                %>
                <div class="tag-div">
                    <a href="#" class="tag-name"><%= tag.getTag() %></a>
                    <span class="tag-count-span">
                        <span class="tag-count-x"> x </span>
                        <span class="tag-count"><%= tag.getCount() %></span>
                    </span>
                </div>
                <% } %>
            </div>
            </div>
        </div>
    </body>
</html>
