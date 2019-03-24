<%-- 
    Document   : viewThread
    Created on : 23 Mar, 2019, 1:38:59 PM
    Author     : robogod
--%>

<%@page import="utilities.ThreadsService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="pojos.Thread"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/header.jsp" %>
        
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
                $('textarea#froala-editor').froalaEditor({
//                    toolbarButtons: ['bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', '|',
//                     'fontFamily', 'fontSize', 'color', 'inlineStyle', 'inlineClass', 'clearFormatting', '|', 
//                     'emoticons', 'fontAwesome', 'specialCharacters', '-', 
//                     'paragraphFormat', 'lineHeight', 'paragraphStyle', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', '|', 
//                     'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', '-', 
//                     'insertHR', 'selectAll', 'getPDF', 'print', 'help', 'html', 'fullscreen', '|',
//                      'undo', 'redo'],
                    toolbarButtons: ['undo', 'redo' , '|', 
                        'bold', 'italic', 'underline', 'fontFamily', 'fontSize', 'color', '|',
                        'strikeThrough', 'subscript', 'superscript', 'outdent', 'indent' ,'-',
                        'align', 'paragraphFormat', 'lineHeight' ,'inlineClass', 'quote', 'clearFormatting','|',
                        'insertLink', 'insertImage', 'html', 'fullscreen']
//                    toolbarButtonsMD: ['undo', 'redo' , '|', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'outdent', 'indent' ,'inlineClass', 'quote', 'clearFormatting', 'insertLink', 'html', 'fullscreen'],
//                    toolbarButtonsSM: ['undo', 'redo' , '|', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'outdent', 'indent' ,'inlineClass', 'quote', 'clearFormatting', 'insertLink', 'html', 'fullscreen'],
//                    toolbarButtonsXS: ['undo', 'redo' , '|', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'outdent', 'indent' ,'inlineClass', 'quote', 'clearFormatting', 'insertLink', 'html', 'fullscreen']
                });
            });
        </script>

        
    </head>
    <body>
        <% 
            String uri = request.getRequestURI();
            int threadID = -1;
            String title = "";
            try {
                threadID = Integer.parseInt(uri.split("/")[3]);
                title = uri.split("/")[4];
            }
            catch(Exception ex) {
                System.out.println(ex.getMessage());
            }
            
            Thread thread = (Thread)session.getAttribute("currentThread");
            if(thread == null || thread.getThreadID() != threadID) {
                
                request.setAttribute("threadID", threadID);
                RequestDispatcher rd = request.getRequestDispatcher("/FetchThread");
                rd.forward(request, response);
            }
            else {
                String requiredTitle = ThreadsService.titleToURL(thread.getTitle());
                if(!title.equals(requiredTitle))
                    response.sendRedirect("/Hanashi/threads/"+threadID+"/"+requiredTitle);
            }
        %>
        
        
        <div id="view-thread-container">
            <div id="originalPost">
                <h3>${currentThread.getTitle()}</h3>
                <div>
                    ${currentThread.getPost()}
                </div>
                <div>
                    ${currentThread.getUsername()}
                    <div>
                        ${currentThread.getTimestampCreated().getTime()}
                    </div>
                </div>
            </div>
            <div id="replies">
            </div>
            <div id="newreply">
                <form action="/Hanashi/CreatePost" id="create-post-form" method="post">
                    <h4> Your Reply </h4>
                    <textarea id="froala-editor" name="post-content"></textarea> <br>
                    <input class="btn btn-success" type="submit" value="Post">
                    <a href="/Hanashi/cancel" class="btn btn-default">Cancel</a>
                </form>
            </div>        
                    
        </div>
    </body>
</html>
