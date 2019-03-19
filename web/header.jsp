<%@page import="pojos.User"%>
<title>Hanashi : </title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="index.css">

<script>
    $(document).ready(function(){
        $('[data-toggle="popover"]').popover(); 
    });
    $('.pop').popover().click(function () {
        setTimeout(function () {
            $('.pop').popover('hide');
        }, 2000);
    });
</script>


<!-- 
    Checking whether user is logged in or not. 
    And thus setting up the Navigation Bar.
-->
<%! 
    boolean flag = false;
    User user = null;
%>
<%
    User user = (User)session.getAttribute("user");
    if(user != null) {
        flag = true;
    }
    else {
        flag = false;
    }
    
%>


<script>
    function whichNav() {

        if(<%= flag %>) {
            $(document).ready(
                    function() {
                        $("#UserDiv").show();
                $("#GuestDiv").hide();
            });
        }
        else {
            $(document).ready(
                    function() {
                        $("#UserDiv").hide();
                $("#GuestDiv").show();
            });
        }
    }
    
    whichNav();
</script>

<%@include file="navbar.jsp"%>

<script>
    $('.pop').popover({ trigger:"manual" }).click(function () {
        var pop = $(this); 
        pop.popover("show") ;
        pop.on('shown.bs.popover',function() { 
            setTimeout(function() {
                pop.popover("hide");}, 10000); 
        }) ;
    });
</script>