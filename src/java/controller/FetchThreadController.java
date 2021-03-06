/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.PostDAO;
import dao.ThreadDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class FetchThreadController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     private void processRequest(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            System.out.println("Log::: Fetching Thread");
            pojos.Thread thread;
            int threadID = -1;
            try {
                threadID = (int)request.getAttribute("threadID");
            }
            catch(Exception e) {
                System.out.println(e.getMessage());
            }
            ThreadDAO td = new ThreadDAO();
            thread = td.fetchThread(threadID);
            User currentUser = (User)session.getAttribute("user");
            
            if(thread == null) {
                out.write("Some Error Occurred!<br> Redirecting...");
                String uri = "/Hanashi/index.jsp";
                String url = request.getScheme() + "://" +
                    request.getServerName() +
                    ("http".equals(request.getScheme()) && request.getServerPort() == 80 || "https".equals(request.getScheme()) && request.getServerPort() == 443 ? "" : ":" + request.getServerPort() ) +uri;
                response.setHeader("Refresh", "3; URL="+url);
            }
            else {
                PostDAO pd = new PostDAO();
                ArrayList<Post> postsList = pd.fetchPosts(threadID);
            
                System.out.println("Log::: Fetched Thread");
                session.setAttribute("posts", postsList);
                session.setAttribute("currentThread", thread);
                response.sendRedirect("/Hanashi/threads/"+thread.getThreadID()+"/"+ThreadsService.encodeTitleToURL(thread.getTitle())+"?"+(String)session.getAttribute("viewThreadTargetPost"));
            }
        } catch (IOException ex) {
            System.out.print(ex.getMessage());
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
                response.setContentType("text/html;charset=UTF-8");
        
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
