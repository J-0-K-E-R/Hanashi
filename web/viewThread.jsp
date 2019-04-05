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
        
        <%! boolean canEdit;%>
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
            System.out.println("Log:::: View Thread");
            Thread thread = (Thread)session.getAttribute("currentThread");
            if(thread == null || thread.getThreadID() != threadID) {
                System.out.println("Log::::  View Thread Not Found");
                request.setAttribute("threadID", threadID);
                RequestDispatcher rd = request.getRequestDispatcher("/FetchThread");
                rd.forward(request, response);
            }
            else {
                System.out.println("Log:::: View Thread Found");
                String requiredTitle = ThreadsService.encodeTitleToURL(thread.getTitle());
                if(!title.equals(requiredTitle))
                    response.sendRedirect("/Hanashi/threads/"+threadID+"/"+requiredTitle); 
            
                if(!isLoggedIn || !user.getUsername().equals(thread.getUsername())) {
                    canEdit = false;
                }
                else {
                    canEdit = true;
                }
            }
        %>
        
        <script>
            function init() {
                if(<%=canEdit%>) {
                    $("#editthread").show();
                }
                else {
                    $("#editthread").hide();
                }
            }
            
            function editUserPost(postid) {
                $('#'+postid).hide();
                $('#edit-'+postid).show();
            }
            
            function cancelEdit(postid) {
                $('#'+postid).show();
                $('#edit-'+postid+'').hide();
            }
        </script>
        
         <script>
            function upvote() {
                var votesspan = document.getElementById("votes-span");
                var xhttp = new XMLHttpRequest();
                var vote = parseInt(votesspan.innerHTML);
                xhttp.onreadystatechange = function() {
                    if (this.readyState === 4 && this.status === 200) {
                        vote = parseInt(this.responseText);
                        votesspan.innerHTML = vote+"";
                    }
                };
                xhttp.open("GET", "/Hanashi/ThreadUpvote", true);
                xhttp.send();
            }
            
            function downvote() {
                var votesspan = document.getElementById("votes-span");
                var xhttp = new XMLHttpRequest();
                var vote = parseInt(votesspan.innerHTML);
                xhttp.onreadystatechange = function() {
                    if (this.readyState === 4 && this.status === 200) {
                        vote = parseInt(this.responseText);
                        votesspan.innerHTML = vote+"";
                    }
                };
                xhttp.open("GET", "/Hanashi/ThreadDownvote", true);
                xhttp.send();
            }
        </script>

        
    </head>
    <body onload="init()">
        
        <div id="main" class="main">
        <div id="view-thread-container">
            <div id="originalPost">
                <div id="thread-header">
                <div id="votes-div">
                    <a href="#" onclick="upvote();">
                        <span class="glyphicon glyphicon-plus-sign"></span>
                    </a> 
                    <br>    
                    <span id="votes-span"> ${currentThread.getVotes()} </span>
                    <br>
                    <a href="#" onclick="downvote();">
                        <span class="glyphicon glyphicon-minus-sign"></span>
                    </a>
                </div>
                
                <h3>${currentThread.getTitle()} </h3>
                <div id="editthread" ><a href="/Hanashi/editthread"><span class="glyphicon glyphicon-edit"></span></a></div>
                
                </div><br>
                <div>
                    ${currentThread.getPost()}
                </div>
                <div>
                    ${currentThread.getUsername()}
                    <div>
                        ${currentThread.getTimestampModified().getTime()}
                    </div>
                </div>
            </div>
            <div id="replies">
                ${posts}
            </div>
            <div id="newreply">
                <form action="/Hanashi/CreatePost" id="create-post-form" method="post">
                    <h4> Your Reply </h4>
                    <textarea id="froala-editor" name="post-content" required></textarea> <br>
                    <input class="btn btn-success" type="submit" value="Post">
                </form>
            </div>        
                    
        </div>
        </div>
    </body>
</html>
