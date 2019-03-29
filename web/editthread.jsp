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
                    <div id="child-tags-list">
                    </div>
                </div>
                <!--<label for="title"> Title </label>-->
                <input type="text" name="title" id="title" placeholder="Enter Title" required="" value="${currentThread.getTitle()}"> <br>
                <input type="text" name="tags" id="input-tags" placeholder="Enter tags separated by semi-colon(;)" onkeyup="addTagsToDiv()" value="${currentThread.getTagsList()}"> <br>
                <textarea id="froala-editor" name="post-content" required>${currentThread.getPost()}</textarea> <br>
                <input class="btn btn-success" type="submit" value="Update">
                <a href="/Hanashi/index.jsp" class="btn btn-default">Cancel</a>
            </form>
        </div>
        </div>
    </body>
</html>
