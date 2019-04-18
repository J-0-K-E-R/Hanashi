<%-- 
    Document   : viewThread
    Created on : 23 Mar, 2019, 1:38:59 PM
    Author     : robogod
--%>

<%@page import="dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Post"%>
<%@page import="utilities.ThreadsService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="pojos.Thread"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/header.jsp" %>
        
        <%! boolean canEdit;
            Thread thread;
            int doesExist;
            String timestampModified;
        %>
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
            thread = (Thread)session.getAttribute("currentThread");
            if(thread == null || thread.getThreadID() != threadID) {
                System.out.println("Log::::  View Thread Not Found");
                request.setAttribute("threadID", threadID);
                RequestDispatcher rd = request.getRequestDispatcher("/FetchThread");
                rd.forward(request, response);
            }
            else {
                System.out.println("Log:::: View Thread Found");
                
                timestampModified = utilities.DateService.relativeDate(thread.getTimestampModified());
                
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
            
            if(isLoggedIn && thread != null) {
                doesExist = dao.ThreadVotesDAO.doesExist(thread.getThreadID(), user.getUsername());
            }    
            else {
                doesExist = 0;
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
                
                changeVoteCSS();
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
            function changeVoteCSS() {
                
                if(<%= doesExist %> === -1) {
                    $(document).ready(function() {
                        $("#minus-sign").addClass("active-vote-sign");
                        if ($('#plus-sign').hasClass('active-vote-sign'))
                            $("#plus-sign").removeClass("active-vote-sign");
                    });
                }
                else if(<%= doesExist %> === 1) {
                    $(document).ready(function() {
                        $("#plus-sign").addClass("active-vote-sign");
                        if ($('#minus-sign').hasClass('active-vote-sign'))
                            $("#minus-sign").removeClass("active-vote-sign");
                    });
                }
                
                else {
                    $(document).ready(function() {
                        if ($('#plus-sign').hasClass('active-vote-sign'))
                            $("#plus-sign").removeClass("active-vote-sign");
                        if ($('#minus-sign').hasClass('active-vote-sign'))
                            $("#minus-sign").removeClass("active-vote-sign");
                    });
                }   
            }
            
            function changeVoteCSSWithParam(doesExist) {
                if(doesExist === -1) {
                    $(document).ready(function() {
                        $("#minus-sign").addClass("active-vote-sign");
                        if ($('#plus-sign').hasClass('active-vote-sign'))
                            $("#plus-sign").removeClass("active-vote-sign");
                    });
                }
                else if(doesExist === 1) {
                    $(document).ready(function() {
                        $("#plus-sign").addClass("active-vote-sign");
                        if ($('#minus-sign').hasClass('active-vote-sign'))
                            $("#minus-sign").removeClass("active-vote-sign");
                    });
                }
                
                else {
                    $(document).ready(function() {
                        if ($('#plus-sign').hasClass('active-vote-sign'))
                            $("#plus-sign").removeClass("active-vote-sign");
                        if ($('#minus-sign').hasClass('active-vote-sign'))
                            $("#minus-sign").removeClass("active-vote-sign");
                    });
                }   
            }
            
            function changePostVoteCSS(doesExist, postID) {
                if(doesExist === -1) {
                    $(document).ready(function() {
                        $("#minus-sign-"+postID).addClass("active-vote-sign");
                        if ($('#plus-sign-'+postID).hasClass('active-vote-sign'))
                            $("#plus-sign-"+postID).removeClass("active-vote-sign");
                    });
                }
                else if(doesExist === 1) {
                    $(document).ready(function() {
                        $("#plus-sign-"+postID).addClass("active-vote-sign");
                        if ($('#minus-sign-'+postID).hasClass('active-vote-sign'))
                            $("#minus-sign-"+postID).removeClass("active-vote-sign");
                    });
                }
                
                else {
                    $(document).ready(function() {
                        if ($('#plus-sign-'+postID).hasClass('active-vote-sign'))
                            $("#plus-sign-"+postID).removeClass("active-vote-sign");
                        if ($('#minus-sign-'+postID).hasClass('active-vote-sign'))
                            $("#minus-sign-"+postID).removeClass("active-vote-sign");
                    });
                }   
            }
            
            function vote(uri) {
                if(<%=isLoggedIn%> === false) {
                    $(function () {
                    $('[data-toggle=popover]').popover('toggle');
                });
                }
                
                else {
                    var votesspan = document.getElementById("votes-span");
                    var xhttp = new XMLHttpRequest();
                    var vote = parseInt(votesspan.innerHTML);
                    xhttp.onreadystatechange = function() {
                        if (this.readyState === 4 && this.status === 200) {
                            var res = this.responseText.split(';');
                            vote = parseInt(res[0]);
                            votesspan.innerHTML = vote+"";
                            changeVoteCSSWithParam(parseInt(res[1]));
                        }
                    };
                    xhttp.open("GET", uri, true);
                    xhttp.send();
                }
            }
            
            function vote_post(postID, uri) {
                if(<%=isLoggedIn%> === false) {
                    $(function () {
                    $('[data-toggle=popover]').popover('toggle');
                });
                }
                
                else {
                    var votesspan = document.getElementById("votes-span-"+postID);
                    var xhttp = new XMLHttpRequest();
                    var vote = parseInt(votesspan.innerHTML);
                    xhttp.onreadystatechange = function() {
                        if (this.readyState === 4 && this.status === 200) {
                            var res = this.responseText.split(';');
                            vote = parseInt(res[0]);
                            votesspan.innerHTML = vote+"";
                            changePostVoteCSS(parseInt(res[1]), postID);
                        }
                    };
                    xhttp.open("GET", uri+"?postID="+postID, true);
                    xhttp.send();
                }
            }
        </script>
        
        <!--Show and hide replies-->
        <script>
            function toggle_replies(postID) {
                var anchor = document.getElementById("toggle-post-"+postID);
                $(document).ready(function() {
                    $("#reply-"+postID).toggle();
                    if(anchor.innerHTML !== "Hide replies")
                        anchor.innerHTML = "Hide replies";
                    else 
                        anchor.innerHTML = "Show replies";
                });
            }
            
            
            function reply_to(postID, uname) {
                if(<%=isLoggedIn%> === false) {
                    $(function () {
                    $('[data-toggle=popover]').popover('toggle');
                });
                }
                else {
                    var ele = document.getElementById("reply_to");
                    ele.value = "@"+postID+";"+uname;
                    
                    $(document).ready(function() {
                        //show reply_to
                        $('#reply_to').show();
                        
                        //show username in froala
                        $('#froala-editor').froalaEditor('html.set',
                        '<span class="reply-to-username fr-deletable" contenteditable="false">@'+uname+'</span> <span contenteditable="true"> </span>');
                        
                        // focus cursor on froala
                        $('#froala-editor').froalaEditor('events.focus', true);
                    
                        // take the cursor to the end of the content in froala
                        var editor = $('#froala-editor').data('froala.editor');
                        editor.selection.setAtEnd(editor.$el.get(0));
                        editor.selection.restore();
                    
                        // scroll to the bottom to reach froala
                        window.scrollTo(0,document.body.scrollHeight);
                    });
                }
            }
        </script>

        
    </head>
    <body onload="init()">
        
        <div id="main" class="main">
        <div id="view-thread-container">
            <div id="originalPost">
                <div id="thread-header">
                <div id="votes-div">
                    <a href="#/" onclick="vote('/Hanashi/ThreadUpvote');">
                        <span id="plus-sign" class="glyphicon glyphicon-plus-sign sign"></span>
                    </a> 
                    <br>    
                    <span id="votes-span"> ${currentThread.getVotes()} </span>
                    <br>
                    <a href="#/" onclick="vote('/Hanashi/ThreadDownvote');">
                        <span id="minus-sign" class="glyphicon glyphicon-minus-sign sign"></span>
                    </a>
                </div>
                
                <%
                    if (thread!= null) {
                        UserDAO us = new UserDAO();
                        User proUser = us.fetchUser(thread.getUsername());
                        String proUsername = proUser.getUsername();
                        String isBanned;
                        if(dao.BannedUsersDAO.isBanned(proUsername)) 
                            isBanned = "Unban User";
                        else
                            isBanned = "Ban User";
                    
                        if(isLoggedIn && user.getPrivilege() <= 2 ){
                %>
                
                <div class="dropdown">
                    <div class="three-dots"></div>
                    <div class="dropdown-content">
                        <a href="/Hanashi/BanUser"> <%=isBanned%></a>
                        <a href="/Hanashi/editthread"> Edit Thread</a>
                        <a href=""> Delete Thread</a>
                        <a href=""> Close Thread</a>
                    </div>
                </div>
                                
                <%
                        }
                    }
                %>    
                    
                <h3>${currentThread.getTitle()} </h3>
                <div id="editthread" ><a href="/Hanashi/editthread"><span class="glyphicon glyphicon-edit"></span></a></div>
                
                </div><br>
                <div>
                    ${currentThread.getPost()}
                </div>
                <div>
                    ${currentThread.getUsername()}
                    <div>
                        <%=timestampModified%>
                    </div>
                </div>
            </div>
            <div id="posts">
                <%
                    for(Post post: (ArrayList<Post>) session.getAttribute("posts")) {      
                %>
                <div class="post-container" id='<%= post.getPostID() %>'>
                    <div class="post-header">
                        <div class="votes-div">
                            <a href="#/" onclick="vote_post(<%= post.getPostID() %>, '/Hanashi/PostDownvote');">
                                <span id="minus-sign-<%= post.getPostID() %>" class="glyphicon glyphicon-minus-sign sign minus-sign"></span>
                            </a>   
                            <span class="votes-span" id="votes-span-<%= post.getPostID() %>"> <%= post.getVotes() %> </span>
                            <a href="#/" onclick="vote_post(<%= post.getPostID() %>, '/Hanashi/PostUpvote');">
                                <span id = "plus-sign-<%= post.getPostID() %>"class="glyphicon glyphicon-plus-sign sign plus-sign"></span>
                            </a>                             
                        </div>
                        
                        <div class='user'> <%= post.getUsername()  %>  
                            <%
                                if(user != null && user.getUsername().equals(post.getUsername())) {
                            %>
                                    <a id="userPostEdit" href="#/" onclick="editUserPost('<%=post.getPostID()%>');">
                                        <span class="glyphicon glyphicon-edit"></span>
                                    </a>
                            <%
                                }
                            %>
                        </div>
                    
                    </div>
                    <div id='post-content'> <%= post.getPost() %> </div> 
                    
                    <div class="btn btn-primary btn-reply" onclick="reply_to(<%=post.getPostID()%>, '<%=post.getUsername()%>');">
                        Reply
                    </div>
                    <div id='timestamp'> <%= utilities.DateService.relativeDate(post.getTimestampModified()) %> </div>
                    
                       
                    
                    <a href="#/" id="toggle-post-<%=post.getPostID()%>" onclick="toggle_replies(<%= post.getPostID() %>);">
                        Show replies 
                    </a>
                    
          
                    
                    <div id="reply-<%= post.getPostID() %>" class="replies"> 
                        
                        <% 
                            dao.PostDAO pd = new dao.PostDAO();
                            ArrayList<Post> replies = pd.fetchReplies(post.getPostID()); 
                            for(Post reply: replies) {
                        %>
                        
                        <div class="reply-container" id='<%= reply.getPostID() %>'>
                            
                            <div class="post-header">
                                <div class="votes-div">
                                    <a href="#/" onclick="vote_post(<%= reply.getPostID() %>, '/Hanashi/PostDownvote');">
                                        <span id="minus-sign-<%= reply.getPostID() %>" class="glyphicon glyphicon-minus-sign sign minus-sign"></span>
                                    </a>    
                                    <span class="votes-span" id="votes-span-<%= reply.getPostID() %>"> <%= reply.getVotes() %> </span>
                                    <a href="#/" onclick="vote_post(<%= reply.getPostID() %>, '/Hanashi/PostUpvote');">
                                        <span id = "plus-sign-<%= reply.getPostID() %>"class="glyphicon glyphicon-plus-sign sign plus-sign"></span>
                                    </a>
                                </div>
                        
                                <div class='user'> <%= reply.getUsername()  %>  
                                    <%
                                        if(user != null && user.getUsername().equals(reply.getUsername())) {
                                    %>
                                            <a id="userPostEdit" href="#/" onclick="editUserPost('<%=reply.getPostID()%>');">
                                                <span class="glyphicon glyphicon-edit"></span>
                                            </a>
                                    <%
                                        }
                                    %>
                                </div>
                    
                            </div>
                            <div id='post-content'> <%= reply.getPost() %> </div> 
                    
                            <div class="btn btn-primary btn-reply" onclick="reply_to(<%=post.getPostID()%>, '<%=reply.getUsername()%>');">
                                Reply
                            </div>
                            <div id='timestamp'> <%= utilities.DateService.relativeDate(reply.getTimestampModified()) %> </div>
 
                        </div>
                            
                        <div id='edit-<%=reply.getPostID() %>' hidden> 
                            <form action="/Hanashi/EditPost?editPostID=<%= reply.getPostID() %>" id="create-post-form" method="post">
                            <textarea id="froala-editor-<%=reply.getPostID() %>" class="froala-editor" name="post-content" required > <%= reply.getPost() %> </textarea> <br>
                            <input class="btn btn-success" type="submit" value="Update">
                            <input type="button" class="btn btn-default" value="Cancel" onclick="cancelEdit('<%=reply.getPostID() %>');">
                            </form>
                        </div>
                        
                        <% } %>
                    </div>
                    
                </div>
            
                <div id='edit-<%=post.getPostID() %>' hidden> 
                    <form action="/Hanashi/EditPost?editPostID=<%= post.getPostID() %>" id="create-post-form" method="post">
                    <textarea id="froala-editor-<%=post.getPostID() %>" class="froala-editor" name="post-content" required > <%= post.getPost() %> </textarea> <br>
                    <input class="btn btn-success" type="submit" value="Update">
                    <input type="button" class="btn btn-default" value="Cancel" onclick="cancelEdit('<%=post.getPostID() %>');">
                    </form>
                </div>
                
                <% } %>
            
            </div>
            <div id="newreply">
                <form action="/Hanashi/CreatePost" id="create-post-form" method="post">
                    <h4> Your Reply </h4>
                    <input type="text" name="reply_to" id="reply_to" class="reply_to" value="">
                    <textarea id="froala-editor" name="post-content" required></textarea> <br>
                    <input class="btn btn-success" type="submit" value="Post">
                </form>
            </div>        
                    
        </div>
        </div>
    </body>
</html>
