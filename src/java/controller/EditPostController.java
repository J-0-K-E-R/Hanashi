/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pojos.Post;
import pojos.User;
import utilities.ThreadsService;

/**
 *
 * @author robogod
 */
public class EditPostController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {           
            
            Post post = new Post();
            PostDAO pd = new PostDAO();
            pojos.Thread currentThread = (pojos.Thread)session.getAttribute("currentThread");
            User user = (User)session.getAttribute("user");
            
            post.setPostID(Integer.parseInt(request.getParameter("editPostID")));
            post.setThreadID(currentThread.getThreadID());
            post.setUsername(user.getUsername());
            post.setPost(request.getParameter("post-content"));
            
            String message = pd.updatePost(post);
            
            if(!message.equals("Done")) {
                out.write(message);
                out.write("Some Error Occurred!<br> Redirecting...");
                String uri = "/Hanashi/index.jsp";
                String url = request.getScheme() + "://" +
                        request.getServerName() +
                        ("http".equals(request.getScheme()) && request.getServerPort() == 80 || "https".equals(request.getScheme()) && request.getServerPort() == 443 ? "" : ":" + request.getServerPort() ) +uri;
                response.setHeader("Refresh", "10; URL="+url);
            }
            else {
                session.removeAttribute("currentThread");
                response.sendRedirect("/Hanashi/threads/"+currentThread.getThreadID()+"/"+ThreadsService.encodeTitleToURL(currentThread.getTitle()));
            }
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
