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
            System.out.println("Log:::: View Thread");
            Thread thread = (Thread)session.getAttribute("currentThread");
            if(thread == null || thread.getThreadID() != threadID) {
                System.out.println("Log::::  View Thread Not Found");
                request.setAttribute("threadID", threadID);
                RequestDispatcher rd = request.getRequestDispatcher("/FetchThread");
                rd.forward(request, response);
            }
            else {
                System.out.println("Log:::: View Thread Found");
                String requiredTitle = ThreadsService.encodeTitleToURL(thread.getTitle());
                if(!title.equals(requiredTitle))
                    response.sendRedirect("/Hanashi/threads/"+threadID+"/"+requiredTitle);
            }
        %>
        
        <div id="main" class="main">
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
                ${posts}
            </div>
            <div id="newreply">
                <form action="/Hanashi/CreatePost" id="create-post-form" method="post">
                    <h4> Your Reply </h4>
                    <textarea id="froala-editor" name="post-content" required></textarea> <br>
                    <input class="btn btn-success" type="submit" value="Post">
                </form>
            </div>        
                    
        </div>
        </div>
    </body>
</html>
