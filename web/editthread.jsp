<%-- 
    Document   : editthread
    Created on : 29 Mar, 2019, 11:38:38 AM
    Author     : robogod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/header.jsp" %>
        <% pojos.Thread currentThread = (pojos.Thread)session.getAttribute("currentThread");%>
        
        <script>
            function addTagsToDiv() {
                var tags = document.getElementById("input-tags").value.split(";");
                var div= document.getElementById("tags-list");
                div.removeChild(document.getElementById("child-tags-list"));
                var newdiv = document.createElement('div');
                newdiv.append("Tags : ");
                newdiv.setAttribute('id', 'child-tags-list');
                tags.forEach(function(j) {
                    i = j.trim();
                    if(i !== "") {
                        var a = document.createElement('a');
                        a.setAttribute('href', '#');
                        a.setAttribute('class', 'btn btn-info');
                        a.innerHTML = i;
                        newdiv.appendChild(a);
                    }
                });
                div.appendChild(newdiv);
            }
        </script>
        <script>
            function init(){
            }
        </script>
        
        
    </head>
    <body onload="init();">
        <div id="main" class="main">
        <div id="create-thread-container">
            <form action="/Hanashi/EditThread" id="create-thread-form" method="post">
                <h2> Edit Thread </h2>
                <div id="tags-list"> 
                    <div id="child-tags-list"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
                    <input type="text" name="title" id="title" class="form-control" placeholder="Enter Title" value="${currentThread.getTitle()}" required="">
                </div>  <br>
                <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-tags"></i></span>
                    <input type="text" name="tags" id="input-tags" placeholder="Enter tags separated by semi-colon(;)" onkeyup="addTagsToDiv()" class="form-control" value="${currentThread.getTagsList()}">
                </div>  <br>
                <textarea class="froala-editor" name="post-content" required>${currentThread.getPost()}</textarea> <br>
                
                <%
                    if(isLoggedIn && user.getPrivilege() <= 2 ){
                %>
                <input type="text" name="comment" id="mod-comment" class="form-control" placeholder="Reason for editing"><br>
                <% } %>
                
                <a href="/Hanashi/index.jsp" class="btn btn-default pull-right">Cancel</a>
                <input class="btn btn-success pull-right" type="submit" value="Update">
            </form>
        </div>
        </div>
    </body>
</html>
