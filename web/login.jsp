<%-- 
    Document   : SignIn
    Created on : 10 Mar, 2019, 3:15:12 PM
    Author     : Joker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/header.jsp"%>
        <script>
            function init() {
                
//                Check if errorMessage is null or not
                var errMessage = "<%=session.getAttribute("errorMessage")%>";
                if(errMessage === null || errMessage === "") {
                    $("#alertError").hide();
                }
                else {
                    $("#alertError").show();
                }
            }
        </script>
        
        
    </head>
    <body onload="init();">
        <div id="main" class="main">
        <div id='loginform-cotainer'>
        <span id="alertError" class='alert alert-danger' hidden> ${errorMessage} </span>
        <form action="/Hanashi/Login?returnto=<%= session.getAttribute("currentURI") %>" method="post">
            <h3>Login</h3> <br>
            <input type="text" name="Username" placeholder="Username" required> <br>
            <input type="password" name="Password" placeholder="Password" required> <br>
            <div class="g-recaptcha" data-sitekey="6Lf9DJsUAAAAAITly5yFz--FY3Olq0oai558XJg-"></div> <br>

            <input type="submit" class="btn btn-success" value="Login">
        </form>
        </div>
        </div>
    </body>
</html>