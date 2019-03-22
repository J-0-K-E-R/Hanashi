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
                $('textarea#froala-editor').froalaEditor({
//                    toolbarButtons: ['bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', '|',
//                     'fontFamily', 'fontSize', 'color', 'inlineStyle', 'inlineClass', 'clearFormatting', '|', 
//                     'emoticons', 'fontAwesome', 'specialCharacters', '-', 
//                     'paragraphFormat', 'lineHeight', 'paragraphStyle', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', '|', 
//                     'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', '-', 
//                     'insertHR', 'selectAll', 'getPDF', 'print', 'help', 'html', 'fullscreen', '|',
//                      'undo', 'redo'],
                    toolbarButtons: ['undo', 'redo' , '|', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'outdent', 'indent' ,'inlineClass', 'quote', 'clearFormatting', 'insertLink', 'html', 'fullscreen']
                });
            });
        </script>
        
        <script>
            function addTagsToDiv() {
                var tags = document.getElementById("input-tags").value.split(",");
//                var form = document.getElementById("create-thread-form");
//                form.removeChild(document.getElementById("tags-list"));
//                var div = document.createElement('div');
//                div.setAttribute('id', 'tags-list');
//                form.appendChild(div);
                var div= document.getElementById("tags-list");
                div.removeChild(document.getElementById("child-tags-list"));
                var newdiv = document.createElement('div');
                newdiv.setAttribute('id', 'child-tags-list');
                tags.forEach(function(j) {
                    i = j.trim();
                    if(i !== "") {
                        var a = document.createElement('a');
                        a.setAttribute('href', '#');
                        a.setAttribute('class', 'btn btn-info');
                        a.innerHTML = i;
                        newdiv.appendChild(a);
                    }
                });
                div.appendChild(newdiv);
            }
        </script>
    </head>
    <body>
        <div id="create-thread-container">
            <form action="/Hanashi/CreateThread" id="create-thread-form" method="post">
                <h2> Create Thread </h2>
                <div id="tags-list"> 
                    <div id="child-tags-list">
                    </div>
                </div>
                <!--<label for="title"> Title </label>-->
                <input type="text" name="title" id="title" placeholder="Enter Title"> <br>
                <input type="text" name="tags" id="input-tags" placeholder="Enter tags separated by comma(,)" onkeyup="addTagsToDiv()"> <br>
                <textarea id="froala-editor" name="post-content"></textarea> <br>
                <input class="btn btn-success" type="submit" value="Post">
                <a href="/Hanashi/cancel" class="btn btn-default">Cancel</a>
            </form>
        </div>
    </body>
</html>
