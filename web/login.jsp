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
        
        <!--Include reCAPTCHA js file-->
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

        <script>
            function init() {
                
            }
        </script>
        
        
    </head>
    <body onload="init();">
        <div id="main" class="main">
            <div id='loginform-cotainer'>

                <% if(session.getAttribute("errorMessage") != null) { %>    

                <span id="alertError" class='alert alert-danger'> ${errorMessage} </span>

                <% } %>
                <br>
                <form action="/Hanashi/Login" method="post">
                    <h2 id="login-text">Log In</h2> <br>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input type="text" name="Username" maxlength="16" class="form-control" placeholder="Username" required>
                        </div>  <br>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input type="password" name="Password" placeholder="Password" class="form-control" required>
                        </div>  <br>

                    <div class="g-recaptcha" data-sitekey="6Lf9DJsUAAAAAITly5yFz--FY3Olq0oai558XJg-"></div> <br>

                    <input type="submit" class="btn btn-success" value="Log In">
                </form>
            </div>
            <div id="login-logo-container">
                <img src="/Hanashi/images/logoD.png">
            </div>
        </div>
    </body>
</html>

<% session.removeAttribute("errorMessage"); %>