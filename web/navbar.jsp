        <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <!-- Logo -->
            <div class="navbar-header">
                <a href="#" class="navbar-brand">Hanashi</a>
            </div>
            <div>
                <ul class="nav navbar-nav navbar-right">
                    <li class="nav-item">
                        <a href="#" 
                           data-html="true"
                           data-toggle="popover"
                           title="Hanashi"
                           data-placement="bottom"
                           data-content='<form action="LogIn" method="post">
                                            <input type="text" name="Username" placeholder="Username" required>
                                            <input type="password" name="Password" placeholder="Password" required>
                                            <input type="submit" value="Log In">
                                         </form>'>
                            <span class="glyphicon glyphicon-log-in"></span>
                             Log In
                        </a>
                    </li>
                    <li class="nav-item"><a href="SignUp.jsp"><span class="glyphicon glyphicon-plua-sign"></span> Sign Up</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <script>
        $(document).ready(function(){
            $('[data-toggle="popover"]').popover(); 
        });
    </script>