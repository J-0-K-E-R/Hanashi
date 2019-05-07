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
            ArrayList<pojos.Post> posts;
            int doesExist;
            String timestampModified;
            int showPostID=-1;
            int targetPostID=-1;
            boolean isClosed = false;
        %>
        <% 
            String uri = request.getRequestURI();
            String queryString = request.getQueryString();
            int threadID = -1;
            String title = "";
            try {
                threadID = Integer.parseInt(uri.split("/")[3]);
                title = uri.split("/")[4];
                if(queryString != null && queryString.split("=").length > 1)
                    targetPostID = Integer.parseInt(queryString.split("=")[1]);
            }
            catch(Exception ex) {
                System.out.println(ex.getClass() +" : "+ ex.getMessage());
                targetPostID = -1;
            }
                       
            
            System.out.println("Log:::: View Thread");
            try {
                if(queryString != null && queryString.split("=").length > 1) {
                    int replyID = Integer.parseInt(queryString.split("=")[1]);
                    String replyTo = new dao.PostDAO().fetchPost(replyID).getReplyTo();
                    if(replyTo != null)
                        showPostID = Integer.parseInt(replyTo);
                    else
                        showPostID = -1;

                    System.out.println("Log ::::: Highlighted Post Is:  "+targetPostID);
                }
                else {
                    System.out.println("Log ::::: There is no Highlighted Post");
                }

            }
            catch(Exception ex) {
                System.out.println(ex.getClass() +" : "+ ex.getMessage() );
                showPostID = -1;
            }
            
            thread = (Thread)session.getAttribute("currentThread");
            if(thread == null || thread.getThreadID() != threadID) {
                System.out.println("Log::::  View Thread Not Found");
                request.setAttribute("threadID", threadID);
                session.setAttribute("viewThreadTargetPost", queryString);
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

                isClosed = dao.ClosedThreadsDAO.isClosed(thread.getThreadID());
            }
            
            if(isLoggedIn && thread != null) {
                doesExist = dao.ThreadVotesDAO.doesExist(thread.getThreadID(), user.getUsername());
            }    
            else {
                doesExist = 0;
            }
            posts = (ArrayList<pojos.Post>) session.getAttribute("posts");
            
        %>
        
        <script>
            function init() {
                changeVoteCSS();
                <% if(showPostID != -1)  { %>
                    
                    showReplies(<%= showPostID %>);
                
                <% } 
                   if(targetPostID != -1) {
                %>
                    
                    highlightTarget(<%= targetPostID %>);
                
                <% } %>
                    
                <%
                    if(posts != null && isLoggedIn)
                    for(pojos.Post post: posts) {
                        %>
                            changePostVoteCSS(<%=dao.PostVotesDAO.doesExist(post.getPostID(), user.getUsername())%>,<%=post.getPostID()%>);
                        <%
                    }
                %>    
                    
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
            
            function showReplies(pid) {
                var anchor = document.getElementById("toggle-post-"+pid);
                anchor.innerHTML = "Hide replies";
                $("#reply-"+pid).toggle();
            }
            
            function highlightTarget(pid) {
                $(document).ready(function() {
                    $("#"+pid).addClass("target-post");
//                    $('#'+pid)[0].scrollIntoView(true);
                    $('html, body').animate({
                        'scrollTop' : $("#"+pid).position().top
                    }, 200);
                });
            }
            
            function toggle_replies(postID) {
                var anchor = document.getElementById("toggle-post-"+postID);
                $(document).ready(function() {
                    if(anchor.innerHTML !== "Hide replies") {
                        anchor.innerHTML = "Hide replies";
                        $("#reply-"+postID).slideDown(250);
                    }
                    else { 
                        anchor.innerHTML = "Show replies";
                        $("#reply-"+postID).slideUp(250);
                    }
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

        <script>
            function reportThread() {
                document.getElementById("input-box-form").action = "/Hanashi/ReportThread";
                toggleInputBox();
            }
            
            function banUser(uname) {
                document.getElementById("input-box-form").action = "/Hanashi/BanUser?username="+uname;
                toggleInputBox();
            }
            
            function reportPost(postID) {
                document.getElementById("input-box-form").action = "/Hanashi/ReportPost?postID="+postID;
                toggleInputBox();
            }
            
            function closeThread() {
                document.getElementById("input-box-form").action = "/Hanashi/CloseThread";
                toggleInputBox();
            }
            
            function openThread() {
                document.getElementById("confirm-box-form").action = "/Hanashi/CloseThread";
                toggleConfirmBox();
            }
            
            function unbanUser(uname) {
                document.getElementById("confirm-box-form").action = "/Hanashi/BanUser?username="+uname;
                toggleConfirmBox();
            }
            
            function toggleInputBox() {
                $(document).ready(function() {
                    $('#input-box-div').fadeToggle('fast');
                    $('#input-box-div').find('.text').prop("value", "");
                });
            }
            
            function toggleConfirmBox() {
                $(document).ready(function() {
                    $('#confirm-box-div').fadeToggle('fast');
                });
            }
        </script>
        
        <script> 
            function showLoginPopover() {
                $(document).ready( function() {
                    $(function () {
                        $('[data-toggle=popover]').popover('toggle');
                    });
                });
            }
        </script>
        
    </head>
    <% if (thread!=null) { %>
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
                    <div id="vDivider"></div>
                    <%
                        if (thread!= null && isLoggedIn ) {
                            UserDAO us = new UserDAO();
                            User proUser = us.fetchUser(thread.getUsername());
                            String proUsername = proUser.getUsername();

                            if(user.getPrivilege() <= 2 ){
                    %>

                    <div class="dropdown">
                        <div class="three-dots"></div>
                        <div class="dropdown-content">
                            <% if(dao.BannedUsersDAO.isBanned(proUsername)) { %>
                            <a  href="#/" onclick="unbanUser('<%=proUsername%>');"> Unban User</a>
                            <% } else { %>
                            <a  href="#/" onclick="banUser('<%=proUsername%>');"> Ban User</a>
                            <% } %>

                            <a href="/Hanashi/editthread"> Edit Thread</a>
                            <a href="/Hanashi/DeleteThread?threadID=<%=thread.getThreadID()%>"> Delete Thread</a>

                            <% if(isClosed) { %>
                            <a href="#/" onclick="openThread();"> Reopen Thread </a>
                            <% } else { %>
                            <a href="#/" onclick="closeThread();"> Close Thread </a>
                            <% } %>
                        </div>
                    </div>

                    <%
                            } else  {
                    %>

                    <div class="dropdown">
                        <div class="three-dots"></div>
                        <div class="dropdown-content">
                            <a href="#/" onclick="reportThread();"> Report Thread</a>
                        </div>
                    </div>



                    <%
                            }
                        }
                    %>    
                    <div id='title-info'>
                        <h2>${currentThread.getTitle()}</h2>
                        <%
                            if(canEdit) {
                        %>

                        <div id="editthread"><a href="/Hanashi/editthread"><span class="glyphicon glyphicon-edit"></span></a></div>

                        <% } %>
                    </div>
                </div>
                <br>
                <hr class="data-divider">
                <div>
                    ${currentThread.getPost()}
                </div>
                <div id='owner-info'>
                    <div id="thread-user"><%=timestampModified%> by <a href='/Hanashi/users/<%= thread.getUsername()%>'>${currentThread.getUsername()}</a> </div>
                </div>
                <br>
            </div>
            <br>
            <hr class="divider">
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
                        <div class='edit-thread'>
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
                        <div id="dropdown" class="pull-right">
                            <%
                                UserDAO us = new UserDAO();
                                User proUser = us.fetchUser(post.getUsername());
                                String proUsername = proUser.getUsername();

                                if(isLoggedIn && user.getPrivilege() <= 2 ){
                            %>

                            <div class="dropdown">
                                <div class="three-dots"></div>
                                <div class="dropdown-content">
                                    <% if(dao.BannedUsersDAO.isBanned(proUsername)) { %>
                                    <a  href="#/" onclick="unbanUser('<%=proUsername%>');"> Unban User</a>
                                    <% } else { %>
                                    <a  href="#/" onclick="banUser('<%=proUsername%>');"> Ban User</a>
                                    <% } %>

                                    <a href="#/" onclick="editUserPost('<%=post.getPostID()%>');" > Edit Post</a>
                                    <a href="/Hanashi/DeletePost?postID=<%=post.getPostID()%>"> Delete Post</a>
                                </div>
                            </div>

                            <%
                                } else if(isLoggedIn) {
                            %>

                            <div class="dropdown">
                                <div class="three-dots"></div>
                                <div class="dropdown-content">
                                    <a href="#/" onclick="reportPost(<%=post.getPostID()%>);"> Report Post</a>
                                </div>
                            </div>

                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div id='post-content'> <%= post.getPost() %> </div> 
                    
                    <div class="btn btn-primary btn-reply" onclick="reply_to(<%=post.getPostID()%>, '<%=post.getUsername()%>');">
                        Reply
                    </div>
                    <div id='timestamp'> <%= utilities.DateService.relativeDate(post.getTimestampModified()) %> by <a href='/Hanashi/users/<%= post.getUsername() %>'><%= post.getUsername()%></a></div>
                    
                       
                    
                    <a href="#/" id="toggle-post-<%=post.getPostID()%>" onclick="toggle_replies(<%= post.getPostID() %>);" class="replies-anchor">
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
                        
                                <div class='edit-post'>  
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
                                    
                                <%
                                    us = new UserDAO();
                                    proUser = us.fetchUser(reply.getUsername());
                                    proUsername = proUser.getUsername();

                                    if(isLoggedIn && user.getPrivilege() <= 2 ){
                                %>

                                <div class="dropdown">
                                    <div class="three-dots"></div>
                                    <div class="dropdown-content">
                                        <% if(dao.BannedUsersDAO.isBanned(proUsername)) { %>
                                        <a  href="#/" onclick="unbanUser('<%=proUsername%>');"> Unban User</a>
                                        <% } else { %>
                                        <a  href="#/" onclick="banUser('<%=proUsername%>');"> Ban User</a>
                                        <% } %>
                                        
                                        <a href="#/" onclick="editUserPost('<%=reply.getPostID()%>');" > Edit Post</a>
                                        <a href="/Hanashi/DeletePost?postID=<%=reply.getPostID()%>"> Delete Post</a>
                                    </div>
                                </div>

                                <%
                                    } else if(isLoggedIn)  {
                                %>

                                <div class="dropdown">
                                    <div class="three-dots"></div>
                                    <div class="dropdown-content">
                                        <a href="#/" onclick="reportPost(<%= reply.getPostID() %>);"> Report Post</a>
                                    </div>
                                </div>                                        
                                        
                                <%
                                    }
                                %>    
                                                    
                            </div>
                            <div id='post-content'> <%= reply.getPost() %> </div> 
                    
                            <div class="btn btn-primary btn-reply" onclick="reply_to(<%=post.getPostID()%>, '<%=reply.getUsername()%>');">
                                Reply
                            </div>
                            <div id='timestamp'> <%= utilities.DateService.relativeDate(reply.getTimestampModified()) %> by <a href='/Hanashi/users/<%= reply.getUsername() %>'><%= reply.getUsername() %></div>
 
                        </div>
                        
                        <%
                            if(user != null && (user.getUsername().equals(reply.getUsername()) || user.getPrivilege() <= 2)) {
                        %>
                            
                        <div id='edit-<%=reply.getPostID() %>' hidden> 
                            <form action="/Hanashi/EditPost?editPostID=<%= reply.getPostID() %>" id="create-post-form" method="post">
                            <textarea id="froala-editor-<%=reply.getPostID() %>" class="froala-editor" name="post-content" required > <%= reply.getPost() %> </textarea>
                            <%
                                if(isLoggedIn && user.getPrivilege() <= 2 ){
                            %>
                            <input type="text" name="comment" id="mod-comment" placeholder="Reason for editing"><br>
                            <% } %>
                            <input class="btn btn-success" type="submit" value="Update">
                            <input type="button" class="btn btn-default" value="Cancel" onclick="cancelEdit('<%=reply.getPostID() %>');">
                            </form>
                        </div>
                        <hr class="replies-divider">
                        <%
                               }
                            } 
                        %>
                    </div>
                </div>
            
                    
                <%
                    if(user != null && (user.getUsername().equals(post.getUsername()) || user.getPrivilege() <= 2 )) {
                %>    
                <div id='edit-<%=post.getPostID() %>' hidden> 
                    <form action="/Hanashi/EditPost?editPostID=<%= post.getPostID() %>" id="create-post-form" method="post">
                    <textarea id="froala-editor-<%=post.getPostID() %>" class="froala-editor" name="post-content" required > <%= post.getPost() %> </textarea> 
                    <%
                        if(isLoggedIn && user.getPrivilege() <= 2 ){
                    %>
                    <input type="text" name="comment" id="mod-comment" placeholder="Reason for editing"><br>
                    <% } %>
                    <input class="btn btn-success" type="submit" value="Update">
                    <input type="button" class="btn btn-default" value="Cancel" onclick="cancelEdit('<%=post.getPostID() %>');">
                    </form>
                </div>
                <hr class="divider">
                <%     
                        }
                    } 
                %>
            
            </div>
                
            <div id="newreply">
                
                <% if(isLoggedIn && !isClosed) { %>
                
                <form action="/Hanashi/CreatePost" id="create-post-form" method="post">
                    <h4> Your Reply </h4>
                    <input type="text" name="reply_to" id="reply_to" class="reply_to" value="">
                    <textarea class="froala-editor" id="froala-editor" name="post-content" required></textarea> <br>
                    <input class="btn btn-success" type="submit" value="Post">
                </form>
                
                <% } else if(!isClosed) { %>
                
                <button id="login-to-answer" class="btn btn-primary" onclick="showLoginPopover()"> Answer </button>
                
                <% } %>
            </div>        
                    
        </div>
        </div>
                
        <div id="input-box-div" class="full-screen-background" hidden>
            <div class="input-box">
                <form id="input-box-form" method="POST">
                    <span>Please enter a comment</span> <br>
                    <input type="text" placeholder="Comment" name="comment" class="text"> <br>
                    <input type="submit" value="Submit" class="btn btn-success my-btn">
                    <input type="button" value="Cancel" class="btn btn-default my-btn"  onclick="toggleInputBox()">
                </form>
            </div>
        </div>
        
        <div id="confirm-box-div" class="full-screen-background" hidden>
            <div class="confirm-box">
                <form id="confirm-box-form" method="POST">
                    <span> Are you sure you want to continue? </span> <br>
                    <input type="submit" value="Yes" class="btn btn-success my-btn">
                    <input type="button" value="Cancel" class="btn btn-default my-btn"  onclick="toggleConfirmBox()">
                </form>
            </div>
        </div>
    </body>
    <% } %>
</html>
