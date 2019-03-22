<%-- 
    Document   : index
    Created on : 8 Mar, 2019, 12:12:24 PM
    Author     : Joker
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="header.jsp"%>

        <script>
            
//            check if user is guest and if not, then is he following the profile user or not
            function onIndexPageLoad() {
                $(document).ready(
                function() {
                    if(<%=session.getAttribute("user")%> === null) {
                        $("#userQuestion").hide();
                $("#guestQuestion").show();
            }
            else {
                $("#guestQuestion").hide();
                $("#userQuestion").show();                
            }
        });
            }
        </script>
        
    </head>
    <body onload="onIndexPageLoad()">
        <a href="/Hanashi/users" class="btn btn-default"> Users </a>
        <a hidden href="/Hanashi/newthread" class="btn btn-info" id="userQuestion"> Ask Question </a>
        <a hidden href="/Hanashi/loginpage" class="btn btn-info" id="guestQuestion"> Ask Question </a>
    </body>
</html>