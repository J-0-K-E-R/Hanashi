/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pojos.Points;
import pojos.User;

/**
 *
 * @author robogod
 */
public class ThreadDownvoteController extends HttpServlet {

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
            System.out.println("Log:::: ThreadVotes");
            
            pojos.Thread currentThread = (pojos.Thread) session.getAttribute("currentThread");
            pojos.User user = (pojos.User) session.getAttribute("user");
            dao.ThreadDAO td = new dao.ThreadDAO();
            
            int threadID = currentThread.getThreadID();
            String username =  user.getUsername();
            String message="";
            int retVal = -1;
            UserDAO ud = new UserDAO();
            User currentThreadUser = ud.fetchUser(currentThread.getUsername());
            
            int doesExist = dao.ThreadVotesDAO.doesExist(threadID, username);
            switch (doesExist) {
                case -1:
                    message =  dao.ThreadVotesDAO.removeThreadVote(threadID, username); 
                    currentThread.setVotes(currentThread.getVotes()+1);
                    td.updateThreadVotes(threadID, currentThread.getVotes());
                    retVal = 0;
                    if(!username.equals(currentThreadUser.getUsername()))
                        currentThreadUser.setPoints(Math.max(1, currentThreadUser.getPoints()+Points.getThreadDownvote()));

                    break;
                case 1:
                    message =  dao.ThreadVotesDAO.voteThread(threadID, username , -1);
                    currentThread.setVotes(currentThread.getVotes()-2);
                    td.updateThreadVotes(threadID, currentThread.getVotes());
                    if(!username.equals(currentThreadUser.getUsername()))
                        currentThreadUser.setPoints(Math.max(1, currentThreadUser.getPoints()-Points.getThreadUpvote()-Points.getThreadDownvote()));
                    break;
                default:
                    message =  dao.ThreadVotesDAO.voteThread(threadID, username , -1);
                    currentThread.setVotes(currentThread.getVotes()-1);
                    td.updateThreadVotes(currentThread.getThreadID(), currentThread.getVotes());
                    if(!username.equals(currentThreadUser.getUsername()))
                        currentThreadUser.setPoints(Math.max(1, currentThreadUser.getPoints()-Points.getThreadDownvote()));
                    break;
            }
            
            
            ud.updateUser(currentThreadUser);
            
            out.write(currentThread.getVotes()+";"+retVal);
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
