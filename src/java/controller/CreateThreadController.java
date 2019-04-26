/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.TagsDAO;
import dao.ThreadDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pojos.User;
import pojos.Thread;
import utilities.ThreadsService;

/**
 *
 * @author robogod
 */
public class CreateThreadController extends HttpServlet {

    

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
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            Thread thread = new Thread(); 
            ThreadDAO td = new ThreadDAO();
            
            System.out.println("Log ::::: Creating Thread");
            
            int threadID = td.getNextThreadID();
            thread.setThreadID(threadID);
            User user = (User)session.getAttribute("user");
            thread.setUsername(user.getUsername());
            
            thread.setTitle(request.getParameter("title"));
            thread.setPost(request.getParameter("post-content"));
            thread.setTagsList(request.getParameter("tags"));
            
            System.out.println("Log ::::: Title is "+ thread.getTitle());
            
            
            thread = td.addNewThread(thread);
            
            TagsDAO tgd = new TagsDAO();
            String message = tgd.updateTags(request.getParameter("tags"));
            
            if(thread == null) {
                out.write("Some Error Occurred!<br> Redirecting...");
                String uri = "/Hanashi/index.jsp";
                String url = request.getScheme() + "://" +
                        request.getServerName() +
                        ("http".equals(request.getScheme()) && request.getServerPort() == 80 || "https".equals(request.getScheme()) && request.getServerPort() == 443 ? "" : ":" + request.getServerPort() ) +uri;
                response.setHeader("Refresh", "3; URL="+url);
            }
            else {
                request.setAttribute("threadID", threadID);
                System.out.println("Log::: Created Thread");
                session.removeAttribute("threads");
                RequestDispatcher rd = request.getRequestDispatcher("/FetchThread");
                rd.forward(request, response);
            }
            
        }
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
