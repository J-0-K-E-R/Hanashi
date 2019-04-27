<script type="text/javascript">
      var onloadCallback = function() {
        grecaptcha.render('recaptcha-div', {
          'sitekey' : '6Lf9DJsUAAAAAITly5yFz--FY3Olq0oai558XJg-'
        });
      };
</script>

<script>
    function expandBar() {
        $(document).ready(function () {
           $("#search_bar").removeClass("col-sm-9"); 
           $("#search_bar").removeClass("col-md-9"); 
           $("#search_bar").addClass("col-md-12"); 
           $("#search_bar").addClass("col-sm-12"); 
        });
        
    }
    
    function collapseBar() {
        $(document).ready(function () {
           $("#search_bar").addClass("col-sm-9"); 
           $("#search_bar").addClass("col-md-9"); 
           $("#search_bar").removeClass("col-md-12"); 
           $("#search_bar").removeClass("col-sm-12"); 
        });
    }
</script>

<nav class="navbar navbar-inverse mynavbar">
    <div class="container-fluid">
        <!-- Logo -->
        <div>
            <a href="/Hanashi/index.jsp" class="pull-left"><img src="/Hanashi/images/logoD.png" id="logo"></a>
        </div>
        <div class="navbar-header">
            <a href="/Hanashi/index.jsp" class="navbar-brand">Hanashi</a>
        </div>
        
        <div class="nav nav-item col-sm-4 col-md-4" >
            <form class="navbar-form" role="search" action="/Hanashi/search">
                <div class="input-group col-sm-9 col-md-9"  id="search_bar">
                    <input type="text" class="form-control" onclick="expandBar();" onblur="collapseBar();" placeholder="Search" name="query" id="query">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </form>
            
        </div>
        
        <% 
            if(session.getAttribute("user") == null) {
        %>
        
        <div id="GuestDiv">
            <ul class="nav navbar-nav navbar-right">
                <li class="nav-item">
                    <a href="#/" 
                        id='login-pop'
                        class="btn pop"
                        data-html="true"
                        data-toggle="popover"
                        title="<img src='/Hanashi/images/logoD.png' id='popover-logo'>"
                        data-placement="bottom"
                        data-content="<form action='/Hanashi/Login' method='post'>
                                        <div class='input-group'>
                                            <span class='input-group-addon'><i class='glyphicon glyphicon-user'></i></span>
                                            <input type='text' name='Username' maxlength='16' class='form-control' placeholder='Username' required>
                                        </div>  <br>
                                        <div class='input-group'>
                                            <span class='input-group-addon'><i class='glyphicon glyphicon-lock'></i></span>
                                            <input type='password' name='Password' placeholder='Password' class='form-control' required>
                                        </div>  <br>
                                        <div id = 'recaptcha-div' style=''></div>
                                        <input type='submit' id='popover-login-button' class='btn btn-success' value='Log In'>
                                      </form>
                                    <script src='https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit' async defer></script>"
                        >
                        <span class="glyphicon glyphicon-log-in"></span>
                        Log In
                    </a>
                </li>
                <li class="nav-item"><a href="/Hanashi/signup"><span class="glyphicon glyphicon-plua-sign"></span> Sign Up</a></li>
            </ul>
        </div>
        
        <%
             } else {
        %>
        
        <div id="UserDiv">
            <ul class="nav navbar-nav navbar-right">
                <li class="nav-item">
                    <a href="#/" 
                       id='profile-pop'
                       class="btn pop"
                       data-html="true"
                       data-toggle="popover"
                       title="<img src='/Hanashi/images/logoD.png' id='popover-logo'>"
                       data-placement="bottom"
                       data-content="<a href='/Hanashi/users/${user.getUsername()}'><img src='${user.getAvatarPath()}' style='width:100px; float: left; margin-bottom: 20px;'><div>
                       
                       <div>${user.getUsername()}</div></a>
                       <div>Email: ${user.getEmail()}</div>
                       <div>Points: ${user.getPoints()}</div>
                       </div>">
                        <span class="glyphicon glyphicon-user"></span>
                        Profile
                    </a>
                </li>
                <li class="nav-item"><a href="/Hanashi/Login"><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
            </ul>
        </div>
                       
        <% } %>               
        
    </div>
</nav>
                       
