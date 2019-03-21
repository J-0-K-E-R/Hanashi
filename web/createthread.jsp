<%-- 
    Document   : createthread
    Created on : 21 Mar, 2019, 8:03:33 PM
    Author     : robogod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="header.jsp" %>
        <!-- Include Editor style. -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href='https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/css/froala_editor.min.css' rel='stylesheet' type='text/css' />
        <link href='https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/css/froala_style.min.css' rel='stylesheet' type='text/css' />
        
        <!-- Include JS file. -->
        <script type='text/javascript' src='https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/js/froala_editor.min.js'></script>
        <script>
            $(function() {
                $('div#froala-editor').froalaEditor({
                });
            });
        </script>
    </head>
    <body>
        <label for="title"> Title </label>
        <input type="text" name="title" id="title" placeholder="Enter Title"> <br>
        
        <div id="froala-editor">
        </div>
        
    </body>
</html>
