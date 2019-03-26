<nav class="navbar navbar-inverse stayontop">
    <div class="container-fluid">
        <!-- Logo -->
        <div class="navbar-header">
            <a href="/Hanashi/index.jsp" class="navbar-brand">Hanashi</a>
        </div>
        
        <div class="nav nav-item col-sm-3 col-md-3">
            <form class="navbar-form" role="search">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" name="srch-term" id="srch-term">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </form>
        </div>
        
        <div id="GuestDiv">
            <ul class="nav navbar-nav navbar-right">
                <li class="nav-item">
                    <a href="#" 
                       class="btn pop"
                       data-html="true"
                       data-toggle="popover"
                       title="Hanashi"
                       data-placement="bottom"
                       data-content="<form action='/Hanashi/Login?returnto=<%= session.getAttribute("currentURI") %>' method='post'>
                       <input type='text' name='Username' placeholder='Username' required autofocus>
                       <input type='password' name='Password' placeholder='Password' required>
                       <input type='submit' value='Log In'>
                       </form>">
                        <span class="glyphicon glyphicon-log-in"></span>
                        Log In
                    </a>
                </li>
                <li class="nav-item"><a href="/Hanashi/signup"><span class="glyphicon glyphicon-plua-sign"></span> Sign Up</a></li>
            </ul>
        </div>
        
        <div hidden id="UserDiv">
            <ul class="nav navbar-nav navbar-right">
                <li class="nav-item">
                    <a href="#" 
                       class="btn pop"
                       data-html="true"
                       data-toggle="popover"
                       title="Hanashi"
                       data-placement="bottom"
                       data-content="<div>
                       <div>Picture</div>
                       <div>Username: ${user.getUsername()}</div>
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
    </div>
</nav>
