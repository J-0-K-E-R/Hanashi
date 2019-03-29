<%@page import="pojos.User"%>
<title>Hanashi : </title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">

<!-- setting the value of currentURI -->
<% 
    String myheaderuri = request.getRequestURI();
    if(!(myheaderuri.equals("/Hanashi/loginpage") || myheaderuri.equals("/Hanashi/signup")))
        session.setAttribute("currentURI", myheaderuri);
%>

<script>
    $(document).ready(function(){
        $('[data-toggle="popover"]').popover(); 
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

<%@include file="/navbar.jsp"%>

<%@include file="/sidenav.jsp"%>

<script>
    $('.pop').popover({ trigger:"manual" }).click(function () {
        var pop = $(this); 
        pop.popover("toggle");
//        pop.on('shown.bs.popover',function() { 
//            setTimeout(function() {
//                pop.popover("hide");
//            }, 30000); 
//        });
    });
    $('body').on('click', function (e) {
    $('[data-toggle=popover]').each(function () {
        // hide any open popovers when the anywhere else in the body is clicked
        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
            $(this).popover('hide');
        }
    });
});
</script>


<!--Is user logged in-->
<% 
    session.setAttribute("isLoggedIn", !(session.getAttribute("user") == null) );
%>

<!-- Include Editor style. -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href='https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/css/froala_editor.min.css' rel='stylesheet' type='text/css' />
<link href='https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/css/froala_style.min.css' rel='stylesheet' type='text/css' />
    
<!-- Include JS file. -->
<script type='text/javascript' src='https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/js/froala_editor.min.js'></script>
    
<!-- Include all Editor plugins CSS style. -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.9.3/css/froala_editor.pkgd.min.css">
    
<!-- Include all Editor plugins JS files. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.9.3/js/froala_editor.pkgd.min.js"></script>
    
<!-- Include Code Mirror CSS. -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
    
<!-- Include Code Mirror JS. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/mode/xml/xml.min.js"></script>
    

