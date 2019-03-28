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
        
        <script>
            function init() {
                
//                Check if errorMessage is null or not
                var errMessage = <%=session.getAttribute("errorMessage")%>;
                if(errMessage === null || errMessage === "") {
                    $("#alertError").hide();
                }
                else {
                    $("#alertError").show();
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
                    text.innerHTML = "Strength: " + strength[result.score]; 
                } else {
                    text.innerHTML = "";
                }
            }
        </script>
        
        <script>
            function alreadyExists(uname) {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("d1").innerHTML = this.responseText;
                    }
                };
                xhttp.open("GET", "aja.jsp?name="+x, true);
                xhttp.send();
            }
        </script>
        
        
    </head>
    
    <body onload="init();">
        <div id="main" class="main">
        <div id="signupform">
            <span id="alertError" class='alert alert-danger'> ${errorMessage} </span>
            <form action="/Hanashi/SignUp?returnto=<%= session.getAttribute("currentURI") %>" method="post">
                <h3> Sign Up </h3>
                <input type="text" name="Username" placeholder="Username" required><br>
                <input type="text" name="Email" placeholder="Email" required><br>
                <div id="password-div">
                    <input type="password" name="Password" id="Password" placeholder="Password" onkeyup="checkStrength()" required> 
                    <meter max="4" id="password-strength-meter"></meter> 
                    <p id="password-strength-text"></p>
                </div>
                <input type="password"  name="cPassword" placeholder="Confirm Password" required><br>
                <input type="submit" value="Sign Up">
            </form>
        </div>
        </div>
    </body>
</html>