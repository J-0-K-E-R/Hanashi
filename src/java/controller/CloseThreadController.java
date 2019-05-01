/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author robogod
 */
public class CloseThreadController extends HttpServlet {

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
            int threadID = ((pojos.Thread) session.getAttribute("currentThread")).getThreadID();
            pojos.User user = (pojos.User)session.getAttribute("user");
            
            if(user == null || user.getPrivilege() > 2) {
                out.write("Access Denied! <br>");
                out.write("Some Error Occurred!<br> Redirecting...");
                String uri = "/Hanashi/index.jsp";
                String url = request.getScheme() + "://" +
                        request.getServerName() +
                        ("http".equals(request.getScheme()) && request.getServerPort() == 80 || "https".equals(request.getScheme()) && request.getServerPort() == 443 ? "" : ":" + request.getServerPort() ) +uri;
                response.setHeader("Refresh", "5; URL="+url);
            }
            else {
                String message;
                if(!dao.ClosedThreadsDAO.isClosed(threadID)) {
                    pojos.ClosedThread cthread = new pojos.ClosedThread();
                    cthread.setThreadID(threadID);
                    cthread.setComment(request.getParameter("comment"));
                    cthread.setClosedBy(user.getUsername());
                    dao.ClosedThreadsDAO.close(cthread);
                } else {
                    dao.ClosedThreadsDAO.open(threadID);
                }
                
                session.removeAttribute("currentThread");

                response.sendRedirect((String)session.getAttribute("currentURI"));
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
