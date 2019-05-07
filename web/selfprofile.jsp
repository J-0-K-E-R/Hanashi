<%-- 
    Document   : selfprofile
    Created on : 4 Apr, 2019, 11:18:17 AM
    Author     : robogod
--%>

<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utilities.DateService"%>
<%@page import="dao.FollowersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        <link href="${pageContext.request.contextPath}/css/imgur.min.css" rel="stylesheet" media="screen">
                <!--Check if profile of the current user is fetched or not-->
        <% 
            
            User proUser = (User)session.getAttribute("user");
            if(proUser == null) {
                String uri = request.getRequestURI();
                String username = null;
                try {
                    username = uri.split("/")[3];              
                }
                catch(Exception ex) {
                    System.out.println(ex.getMessage());
                }
                
                System.out.println("Log:::::: User not logged in!");
                request.getRequestDispatcher("/users/"+username).forward(request, response);
            }
            else {
                System.out.println("Log::::: Current Profile Found");
            }
            
            
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
            

        %>

        
        <script>
            
//            check if user is guest and if not, then is he following the profile user or not
            function pageLoader() {
                
            }
        </script>
   
           
    </head>
    
    <body onload="pageLoader()">
        
        <div id="main" class="main">
        <div id="user-profile-container">
            
            <div id="top">
                <div class="profile-picture">
                    <a href="#/" onclick="toggleDropzone();">
                        <img src="${profileUser.getAvatarPath()}" class="profile-picture">
                    </a>
                </div>
                    
                <div id="userdata">
                    <div id="username">
                        ${profileUser.getUsername()}
                    </div>
                    
                    <div id="points">
                        Points - ${profileUser.getPoints()}
                    </div>

                    <div id="followers-following">
                        <a href="/Hanashi/users?query=followers&username=${profileUser.getUsername()}"  class="btn btn-info"> Followers ${profileUser.getFollowersCount()} </a>
                        <a href="/Hanashi/users?query=following&username=${profileUser.getUsername()}"  class="btn btn-info"> Following ${profileUser.getFollowingCount()} </a>
                    </div>
                </div>
                
                <br style="clear:both;"/>
            </div>
            
            <hr class="data-divider">
            
            <div id="user-threads">
                <div id="sortby">
                    <div class="btn-group pull-right">
                        <a href="/Hanashi/users/${profileUser.getUsername()}?sortby=Timestamp_Modified" class="btn btn-default"> Newest </a>
                        <a href="/Hanashi/users/${profileUser.getUsername()}?sortby=Votes" class="btn btn-default"> Popular </a>
                    </div>
                </div>
                <%
                    for(pojos.Thread thread: (ArrayList<pojos.Thread>)session.getAttribute("userThreads")) {
                %>
                <div id='thread-container'>
                    <div id='votes'> Votes: <%= thread.getVotes() %></div>
                    <div class="vDivider"></div>
                    <div id='thread-title'> <a href='/Hanashi/threads/<%= thread.getThreadID() %>'><%= thread.getTitle() %></a></div>
                    <div id='timestamp'><%= DateService.relativeDate(thread.getTimestampModified()) %></div>
                </div>
                <hr class="divider">
                <% } %>
            </div>
        </div>
        </div>
            
                
        <div id="dropzone-div" class="full-screen-background" hidden>
            <div class="dropzone-div-container">
                <div class="dropzone"></div>
                <input type="button" class="btn btn-default my-btn" value="Cancel" onclick="toggleDropzone();">
            </div>
            
        </div>
            
        <!--imgur image upload-->
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/imgur.min.js"></script>
        <script type="text/javascript">
            var feedback = function (res) {
                if (res.success === true) {
                    var status = document.querySelector('.status');
                    var p = document.createElement('p');
                    var t = document.createTextNode('Image uploaded successfully!');
                    var link = res.data.link;
                    
                    updateImageURL(link);
                    
                    p.appendChild(t);

                    status.classList.add('bg-success');
                    status.appendChild(p);
                    toggleDropzone();
                    // document.querySelector('.status').innerHTML = 'Image url: ' + res.data.link;
                }
            };

            new Imgur({
                clientid: '02f4ec639f412f8',
                callback: feedback
            });
        </script>
        
        <script> 
            function updateImageURL(mylink) {
                $.ajax({
                    type : "POST",
                    data : {
                        link: mylink
                    },
                    success: function(result) {
                        console.log(result);
                    },
                    url : "/Hanashi/UpdateAvatar"
                });
            }
        </script>

        <script>
            function toggleDropzone() {
                $("#dropzone-div").fadeToggle(200);
            }
        </script>
    </body>
</html>