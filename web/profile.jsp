<%-- 
    Document   : profile
    Created on : 14 Mar, 2019, 2:55:56 PM
    Author     : Joker
--%>

<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page import="utilities.DateService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.FollowersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        
        <!--Check if profile of the current user is fetched or not-->
        <%!
            User proUser;
            String commentBoxURI;
        %>
        <% 
            String uri = request.getRequestURI();
            String username = null;
            try {
                username = uri.split("/")[3];              
            }
            catch(Exception ex) {
                System.out.println(ex.getMessage());
            }
            
            proUser = (User)session.getAttribute("profileUser");
            if(proUser == null || !proUser.getUsername().equals(username)) {
                request.setAttribute("profileUsername", username);
                RequestDispatcher rd = request.getRequestDispatcher("/Profile");
                rd.forward(request, response);
            }
            else if(user != null && user.getUsername().equals(username)) {
                RequestDispatcher rd = request.getRequestDispatcher("/myprofile/"+username);
                rd.forward(request, response);                
            }
            else {
                System.out.println("Log::::: Profile Found");
                if(session.getAttribute("user") == null ) {
                    session.setAttribute("isFollowing", null);
                }
                else {
                    FollowersDAO fd = new FollowersDAO();
                    boolean isFollowing =  fd.isFollowing(user.getUsername(), proUser.getUsername());
                    
                    
                    session.setAttribute("isFollowing", isFollowing);
                    
                    if(user.getPrivilege() <= 2) {
                        commentBoxURI = "/Hanashi/BanUser?username=" + proUser.getUsername();
                    }
                    else {
                        commentBoxURI = "/Hanashi/ReportUser?username=" + proUser.getUsername();
                    }
                }
                
                dao.ThreadDAO td = new dao.ThreadDAO();
            
                
                
                // Sort By options on user threads
                String query;
                try {
                    query = request.getQueryString().split("=")[1].trim();
                    if(!query.equals("Votes") && !query.equals("Timestamp_Modified")) {
                        System.out.println("Log ::::: Unknown sort by +"+query);
                        query="";
                    }
                    else {
                        System.out.println("Log :::: sort by " + query);
                    }
                } catch(Exception e) {
                    query="";
                }

                ArrayList<pojos.Thread> threadsList = (ArrayList<pojos.Thread>)session.getAttribute("userThreads");
                if(query.equals("")) {
                    
                }
                else if(query.equals("Timestamp_Modified")) {
                    Collections.sort(threadsList, new Comparator<pojos.Thread>() {
                        @Override
                        public int compare(pojos.Thread o1, pojos.Thread o2) {
                            return o1.getTimestampModified().compareTo(o2.getTimestampModified());
                        }
                    }.reversed());
                }
                else if(query.equals("Votes")) {
                    Collections.sort(threadsList, new Comparator<pojos.Thread>() {
                        @Override
                        public int compare(pojos.Thread o1, pojos.Thread o2) {
                            int v1 = o1.getVotes();
                            int v2 = o2.getVotes();
                            return (v1 == v2) ? 0 : (v1 < v2 ? -1 : 1);
                        }
                    }.reversed());
                }
                session.setAttribute("userThreads", threadsList); 

            }
            

        %>

        
        <% if(proUser != null) { %>
        
        <script>
            
            function init() {
                initializeFollowButtonText();
            }
        </script>
        
        <script>
            
            //            check if user is guest and if not, then is he following the profile user or not
            function initializeFollowButtonText() {
                var followbutton = document.getElementById("follow-button");
                
                if(<%=session.getAttribute("isFollowing")%> === true) 
                    followbutton.innerHTML = "Unfollow";
                else 
                    followbutton.innerHTML = "Follow";
            }
            
            function setFollowButtonText(isFollowing) {
                var followbutton = document.getElementById("follow-button");
                
                if(isFollowing) 
                    followbutton.innerHTML = "Unfollow";
                else 
                    followbutton.innerHTML = "Follow";
            }
            
            function setFollowersCount(isFollowing, followersCount) {
                var followerscount = document.getElementById("followers-count");
                
                if(isFollowing) 
                    followerscount.innerHTML = "Followers " + followersCount;
                else 
                    followerscount.innerHTML = "Followers " + followersCount;
            }
        </script>
        
        <script>
            function toggleInputBox() {
                $(document).ready(function() {
                    $('.full-screen-background').fadeToggle('fast');
                    $('.full-screen-background').find('.text').prop("value", "");
                });
            }
            
        </script>
        
        <script> 
             function followUser() {
                if(<%=isLoggedIn%> === false) {
                    $(function () {
                    $('[data-toggle=popover]').popover('toggle');
                });
                }
                
                else {
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (this.readyState === 4 && this.status === 200) {
                            var res = JSON.parse(this.responseText);
                            setFollowButtonText(res.isFollowing);
                            setFollowersCount(res.isFollowing, res.followersCount);
                        }
                    };
                    xhttp.open("GET", "/Hanashi/FollowUser", true);
                    xhttp.send();
                }
            }
        </script>
        
        <% } %>
    
    </head>
    
    <body onload="init();">
        
        <div id="main" class="main">
        <div id="user-profile-container">
            
            <div id="top">
                
                <%
                    
                    String proUsername = "";
                    if(proUser != null)
                        proUsername= proUser.getUsername();
                    String isBanned;
                    if(dao.BannedUsersDAO.isBanned(proUsername)) 
                        isBanned = "Unban User";
                    else
                        isBanned = "Ban User";
                    String isMod;
                    if(proUser != null && proUser.getPrivilege() == 2)
                        isMod = "Demote";
                    else
                        isMod = "Promote";
                    
                    if(isLoggedIn && user.getPrivilege() <= 2 ){
                %>
                <div class="dropdown">
                    <div class="three-dots"></div>
                    <div class="dropdown-content">
                        <a  href="#/" onclick="toggleInputBox();"> <%=isBanned%></a>
                        
                        <%
                            if(user.getPrivilege() == 1) {
                                %>
                                    <a href="/Hanashi/PromoteDemoteMod"> <%=isMod%></a>
                                <%
                            }
                        %>
                        
                    </div>
                </div>
                                
                <%
                        } else if (isLoggedIn)  {
                %>
                
                <div class="dropdown">
                    <div class="three-dots"></div>
                    <div class="dropdown-content">
                        <a href="#/" onclick="toggleInputBox();"> Report User</a>
                    </div>
                </div>
                
                           
                <%
                    }              
                %>                
                
                <div class="profile-picture">
                    <a href="/Hanashi/users/${profileUser.getUsername()}">
                        <img src="${profileUser.getAvatarPath()}" class="profile-picture">
                    </a>
                </div>
                <div id="username">
                    ${profileUser.getUsername()}
                </div>
                <div id="points">
                    Points ${profileUser.getPoints()}
                </div>
                
                <div id="followers-following">
                    <a id="followers-count" href="#"  class="btn btn-info"> Followers ${profileUser.getFollowersCount()} </a>
                    <a id="following-count" href="#"  class="btn btn-info"> Following ${profileUser.getFollowingCount()} </a>
                </div>
                
                <button id="follow-button" class= "btn btn-default" onclick="followUser();" >  </button>    
                
                <br style="clear:both;"/>
            </div>
            <div id="user-threads">
                <div id="sortby">
                    <a href="/Hanashi/users/${profileUser.getUsername()}?sortby=Timestamp_Modified" class="btn btn-default"> Newest </a>
                    <a href="/Hanashi/users/${profileUser.getUsername()}?sortby=Votes" class="btn btn-default"> Popular </a>
                </div>
                <%
                    for(pojos.Thread thread: (ArrayList<pojos.Thread>)session.getAttribute("userThreads")) {
                %>
                <div id='thread-container'>
                    <div id='votes'> Votes: <%= thread.getVotes() %></div>
                    <div id='thread-title'> <a href='/Hanashi/threads/<%= thread.getThreadID() %>'><%= thread.getTitle() %></a></div>
                    <div id='timestamp'><%= DateService.relativeDate(thread.getTimestampModified()) %></div>
                </div>
                <% } %>
            </div>
        </div>
        </div>
            
        <div class="full-screen-background" hidden>
            <div class="input-box">
                <form action="<%= commentBoxURI%>" method="POST">
                    <span>Please enter a comment</span> <br>
                    <input type="text" placeholder="Comment" name="comment" class="text"> <br>
                    <input type="submit" value="Report" class="btn btn-success my-btn">
                    <input type="button" value="Cancel" class="btn btn-default my-btn"  onclick="toggleInputBox()">
                </form>
            </div>
        </div>
    </body>
</html>
