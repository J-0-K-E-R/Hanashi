/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.FollowersDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pojos.User;

/**
 *
 * @author Joker
 */
@WebServlet(name = "FollowUpdateController", urlPatterns = {"/FollowUser"})
public class FollowUpdateController extends HttpServlet {

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
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            User user1 = (User)session.getAttribute("user");
            User user2 = (User)session.getAttribute("profileUser");
            
            user1.setFollowingCount(user1.getFollowingCount()+1);
            user2.setFollowersCount(user2.getFollowersCount()+1);
            UserDAO ud = new UserDAO();
            ud.updateUser(user2);
            ud.updateUser(user1);
            FollowersDAO fd = new FollowersDAO();
            fd.updateFollowers(user1.getUsername(), user2.getUsername());
            response.sendRedirect("/Hanashi/users/"+user2.getUsername());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FollowUpdateController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
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
