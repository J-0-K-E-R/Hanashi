<%-- 
    Document   : createthread
    Created on : 21 Mar, 2019, 8:03:33 PM
    Author     : robogod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/header.jsp" %>
        
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
                        a.setAttribute('class', 'btn btn-info btn-sm');
                        a.innerHTML = i;
                        newdiv.appendChild(a);
                    }
                });
                div.appendChild(newdiv);
            }
        </script>
    </head>
    <body>
        <div id="main" class="main">
        <div id="create-thread-container">
            <form action="/Hanashi/CreateThread" id="create-thread-form" method="post">
                <h2> Create Thread </h2>
                <div id="tags-list">
                    <div id="child-tags-list"></div>
                </div>
                <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
                    <input type="text" name="title" id="title" class="form-control" placeholder="Enter Title" required="">
                </div>  <br>
                <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-tags"></i></span>
                    <input type="text" name="tags" id="input-tags" placeholder="Enter tags separated by semi-colon(;)" onkeyup="addTagsToDiv()" class="form-control">
                </div>  <br>
                <textarea class="froala-editor" name="post-content" required></textarea> <br>
                <a href="/Hanashi/index.jsp" class="btn btn-danger pull-right">Cancel</a>
                <input class="btn btn-success pull-right" type="submit" value="Post">
            </form>
        </div>
        </div>
    </body>
</html>
