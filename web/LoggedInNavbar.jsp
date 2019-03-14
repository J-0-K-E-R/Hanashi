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
                           data-content='Profile'>
                            <span class="glyphicon glyphicon-user"></span>
                             Profile
                        </a>
                    </li>
                    <li class="nav-item"><a href="LogIn"><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <script>
        $(document).ready(function(){
            $('[data-toggle="popover"]').popover(); 
        });
    </script>