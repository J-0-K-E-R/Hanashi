<%-- 
    Document   : SignUp
    Created on : 10 Mar, 2019, 4:30:11 PM
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
        
        
        <script>
            function matchPass() {
                var pass = document.getElementById("Password").value;
                var cpass = document.getElementById("cPassword").value;
                var out = document.getElementById("alertPassMatch");
                if(cpass === "") {
                    out.hidden = true;
                }
                else if(pass === cpass) {
                    out.hidden = false;
                    out.innerHTML = "Matched!";
                    out.className = "alert alert-success";
                }
                else {
                    out.hidden = false;
                    out.innerHTML = "Do Not Match!";
                    out.className = "alert alert-danger";
                }
            }
        </script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
        <script>
            var strength = {
                0: "Worst",
                1: "Bad",
                2: "Weak",
                3: "Good",
                4: "Strong"
            };
            
            function checkStrength() {
                var password = document.getElementById('Password');
                var meter = document.getElementById('password-strength-meter');
                var text = document.getElementById('password-strength-text');
                var val = password.value;
                var result = zxcvbn(val);
        
                // Update the password strength meter
                meter.value = result.score;
        
                // Update the text indicator
                if (val !== "") {
                    text.innerHTML = " " + strength[result.score]; 
                } else {
                    text.innerHTML = "";
                }
            }
        </script>
        
        <script>
            function alreadyExists(uname) {
                
                var xhttp = new XMLHttpRequest();
                var span = document.getElementById("validateUserAlert");
                xhttp.onreadystatechange = function() {
                    if (this.readyState === 4 && this.status === 200) {
                        var res = JSON.parse(this.responseText);
                        if(!res.doesExist) {
                            span.innerHTML = "Available";
                            span.className = "alert alert-success";
                        }
                        else {
                            span.innerHTML = "Not Available";
                            span.className = "alert alert-danger";
                        }
                        return res.doesExist();
                    }
                };
                xhttp.open("GET", "/Hanashi/UsernameExists?uname="+uname, true);
                xhttp.send();
            }
            
            
            function validateUser() {
                var uname = document.getElementById("uname").value;
                var unametext = document.getElementById("uname");
               
                if(uname === "") 
                    $("#validateUserAlert").hide();
                else 
                    $("#validateUserAlert").show();
                
                var unameregex = /^[a-zA-Z0-9_]+$/;
                if(unameregex.test(uname) === true) {
                    alreadyExists(uname);
                }
                else {
                    var span = document.getElementById("validateUserAlert");
//                    unametext.value = uname.slice(0, -1);
                    span.innerHTML = "Invalid Username";
                    span.className = "alert alert-danger";
                }
            }
            
            function validateEmail() {
                var mail = document.getElementById("email").value;
               
                if(mail === "") 
                    $("#validateEmailAlert").hide();
                else 
                    $("#validateEmailAlert").show();
                if (/^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i.test(mail)) {
                    $("#validateEmailAlert").hide();
                } else {
                    var span = document.getElementById("validateEmailAlert");
                    span.innerHTML = "Invalid Email";
                    span.className = "alert alert-danger";
                }
            }
            
        </script>
        
        
    </head>
    
    <body onload="init();">
        <div id="signup-main" class="main">
            <div id="signupform">
                
                <% if(session.getAttribute("errorMessage") != null) { %>

                    <span id="alertError" class='alert alert-danger' hidden>  ${errorMessage} </span>
                <% } %>
                <br>
                <form  action="/Hanashi/SignUp" method="post">
                    <h2 id="signup-text"> Sign Up </h2><br>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input type="text" id="uname" name="Username" placeholder="Username" maxlength="16" class="form-control" onkeyup="validateUser();" required>
                    </div> 
                    <div class="alerts-div">
                        <span id="validateUserAlert" hidden> </span>
                    </div>  <br>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                        <input type="text" id="email" name="Email" placeholder="Email" maxlength="50" onkeyup="validateEmail()" class="form-control" required>
                    </div> 
                    <div class="alerts-div">
                        <span id="validateEmailAlert" hidden> </span>
                    </div>  <br>

                    <div id="password-div">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input type="password" name="Password" id="Password" placeholder="Password" onkeyup="checkStrength()" class="form-control" required>
                        </div>
                    </div>
                    <div id="pass-alerts-div">
                        <span id="password-strength-text"> </span>
                    </div>
                    <meter max="4" id="password-strength-meter"></meter> <br>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-check"></i></span>
                        <input type="password" id="cPassword" name="cPassword" placeholder="Confirm Password" onkeyup="matchPass()" class="form-control" required>
                    </div>
                    <div class="alerts-div">
                        <span id="alertPassMatch"> </span>
                    </div>  <br>

                    <div class="g-recaptcha" data-sitekey="6Lf9DJsUAAAAAITly5yFz--FY3Olq0oai558XJg-"></div><br>
                    <div id="signup-submit"><input type="submit" class="btn btn-success" value="Sign Up"></div>
                </form>
            </div>
            <div id="signup-logo-container">
                <img src="/Hanashi/images/logoD.png">
            </div>
        </div>
    </body>
</html>