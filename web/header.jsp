<%@page import="pojos.User"%>
<title>Hanashi : Cumulation Of Wisdom</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
<link rel="shortcut icon" type="image/png" href="/Hanashi/images/favicon.png">

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
    boolean isLoggedIn = false;
    User user = null;
%>
<%
    User user = (User)session.getAttribute("user");
    if(user != null) {
        isLoggedIn = true;
    }
    else {
       isLoggedIn = false;
    }
    
%>


 <!--Top Nav Bar-->
<%@include file="/navbar.jsp"%>

 
<!--Side Nav--> 
<div class="sidenav">
    <a href="/Hanashi/index.jsp"><span class="glyphicon glyphicon glyphicon-home"></span>Home</a>
    <hr class="sidenav-divider">
    <% 
        if(isLoggedIn) {
            if(user.getPrivilege() <= 2) {
                %>
                    <a href="/Hanashi/dashboard#notifications"><span class="glyphicon glyphicon glyphicon-list"></span>Dashboard</a>
                <%
            }
        }
    %>
    <hr class="sidenav-divider">
    <a href="/Hanashi/users"><span class="glyphicon glyphicon glyphicon-user"></span>Users</a>
    <hr class="sidenav-divider">
    <a href="/Hanashi/tags"><span class="glyphicon glyphicon glyphicon-tags"></span>Tags</a>
    <hr class="sidenav-divider">
    <a href="/Hanashi/newthread"><span class="glyphicon glyphicon glyphicon-pencil"></span>Ask Question</a>
    <hr class="sidenav-divider">
</div> 

    
    
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
    
    $('.dropdown').each(function () {
        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown').has(e.target).length === 0) {
            $('.dropdown-content').slideUp(200);
        }
    });
    
});
</script>


<!--Is user logged in-->
<% 
    session.setAttribute("isLoggedIn", !(session.getAttribute("user") == null) );
%>




<!--Froala Editor stuff-->

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
    
    
<script>
    $(function() {        
        $('textarea.froala-editor').froalaEditor({
            // toolbarButtons: ['bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', '|',
            // 'fontFamily', 'fontSize', 'color', 'inlineStyle', 'inlineClass', 'clearFormatting', '|', 
            // 'emoticons', 'fontAwesome', 'specialCharacters', '-', 
            // 'paragraphFormat', 'lineHeight', 'paragraphStyle', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', '|', 
            // 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', '-', 
            // 'insertHR', 'selectAll', 'getPDF', 'print', 'help', 'html', 'fullscreen', '|',
            // 'undo', 'redo'],
            toolbarButtons: ['undo', 'redo' , '|', 
                'bold', 'italic', 'underline', 'fontFamily', 'fontSize', 'color', '|',
                'strikeThrough', 'subscript', 'superscript', '-' , 
                'outdent', 'indent' , 'align', 'lineHeight' ,'inlineClass', 'quote', 'clearFormatting','|',
                'insertLink', 'insertImage', 'html', 'fullscreen'],
            
           inlineClasses: {
                'fr-class-code': 'Code',
                'fr-class-highlighted': 'Highlighted'
            },
            
            // Set the image upload parameter.
            imageUploadParam: 'file',

            // Set the image upload URL.
            imageUploadURL: '/Hanashi/UploadArticleImage',

            // Additional upload params.
//            imageUploadParams: {id: 'my_editor'},

            // Set request type.
            imageUploadMethod: 'POST',

            // Set max image size to 10MB.
            imageMaxSize: 10 * 1024 * 1024,

            // Allow to upload PNG and JPG.
            imageAllowedTypes: ['jpeg', 'jpg', 'png']
          })
          .on('froalaEditor.image.beforeUpload', function (e, editor, images) {
            // Return false if you want to stop the image upload.
          })
          .on('froalaEditor.image.uploaded', function (e, editor, response) {
            // Image was uploaded to the server.
            // Parse response to get image url.
//            var img_url =  JSON.parse(response).link;
//            alert(img_url);
//
//            // Insert image.
//            editor.image.insert(img_url, false, null, editor.image.get(), response);
//
//            return false;
          })
          .on('froalaEditor.image.inserted', function (e, editor, $img, response) {
            // Image was inserted in the editor.
          })
          .on('froalaEditor.image.replaced', function (e, editor, $img, response) {
            // Image was replaced in the editor.
          })
          .on('froalaEditor.image.error', function (e, editor, error, response) {
            // Bad link.
            if (error.code === 1) { alert('Bad link'); }
            
            // No link in upload response.
            else if (error.code === 2) { alert('No link in upload response'); }

            // Error during image upload.
            else if (error.code === 3) { alert('Error during image upload'); }

            // Parsing response failed.
            else if (error.code === 4) { alert('Parsing response failed'); }

            // Image too text-large.
            else if (error.code === 5) { alert('Image too text-large.'); }

            // Invalid image type.
            else if (error.code === 6) { alert('Invalid image type'); }

            // Image can be uploaded only to same domain in IE 8 and IE 9.
            else if (error.code === 7) { alert('Image can be uploaded only to same domain in IE 8 and IE 9.'); }

            // Response contains the original server response to the request if available.
          });
            
        });
</script>
        
        
<script>
    //Show drop down on click
    $(document).ready(function() {
        $('.dropdown').click(function() {
            jQuery(".dropdown-content", this).toggle('fast');
        });
    });
</script>
        


