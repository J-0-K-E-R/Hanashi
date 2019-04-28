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
        <style>
            /* Popover */
            .tag-div .popover {
                border: 1px solid #222;
                max-width: 300px;
                width: auto;
                background-color: white;
            }
                
            .tag-div .popover-title {
                background-color: white; 
                color: darkblue;
                font-size: 19px;
                text-align: center;
            }
                
            .tag-div .popover-content {
                background-color: white;
                color: darkblue;
                padding: 6px;
                text-align: center;
            }
        </style>
        
        <script>
            function isFollowing(tag) {
                var tag_btn = document.getElementById("follow-tag-"+tag);
                if(<%=isLoggedIn%> === true) {
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (this.readyState === 4 && this.status === 200) {
                            var res = JSON.parse(this.responseText);
                            if(res.doesExist) 
                                tag_btn.value = "Unfollow";
                            else 
                                tag_btn.value = "Follow";
                                
                        }
                    };
                    xhttp.open("GET", "/Hanashi/TagFollowed?tag="+tag, true);
                    xhttp.send();
                }
                else {
                    tag_btn.value = "Follow";
                }
            }
            
            function followTag(tag) {
                if(<%=isLoggedIn%> === false) {
                    $(function () {
                        $('#login-pop').popover('toggle');
                    });
                }
                else {
                    var tag_btn = document.getElementById("follow-tag-"+tag);
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (this.readyState === 4 && this.status === 200) {
                            var res = JSON.parse(this.responseText);
                            if(res.doesExist) 
                                tag_btn.value = "Unfollow";
                            else 
                                tag_btn.value = "Follow";
                                
                        }
                    };
                    xhttp.open("GET", "/Hanashi/FollowTag?tag="+tag, true);
                    xhttp.send();
                }
            }
        </script>
        
    </head>
    <body>
        <% 
            
            dao.TagsDAO td = new dao.TagsDAO();
            ArrayList<Tag> tagsList = td.fetchTags();
            session.setAttribute("tagsList", tagsList);

        %>
        <div id="main" class="main">
            <div id="tags-list-wrapper">
            <h2>Tags</h2>
            <div class="grid-container">
                <%
                    for(Tag tag: (ArrayList<Tag>)session.getAttribute("tagsList")) {
                %>
                <div class="tag-div" onclick='isFollowing("<%= tag.getTag() %>");'>
                    <a href="#/"
                       id='<%= tag.getTag() %>'
                       class="pop tag-name"
                       data-html="true"
                       data-toggle="popover"
                       title="<%= tag.getTag() %>"
                       data-placement="bottom"
                       data-content="<input type='button' class='btn btn-success' id='follow-tag-<%= tag.getTag() %>' value='...' onclick='followTag(&quot;<%= tag.getTag() %>&quot;);'>"
                        >
                        <span > <%= tag.getTag() %> </span>
                    </a>
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
