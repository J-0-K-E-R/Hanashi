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
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            System.out.println("Log ::::: FollowUpdateController");
            
            String message = "";
            User user1 = (User)session.getAttribute("user");
            User user2 = (User)session.getAttribute("profileUser");
            
            FollowersDAO fd = new FollowersDAO();
            
            boolean isFollowing =  fd.isFollowing(user1.getUsername(), user2.getUsername());
                    
            if(!isFollowing) {
                message = fd.addFollowers(user1.getUsername(), user2.getUsername());

                if(message.equals("Done")) {
                    user1.setFollowingCount(user1.getFollowingCount()+1);
                    user2.setFollowersCount(user2.getFollowersCount()+1);
                }
                session.setAttribute("isFollowing", true);
                System.out.println("Log ::::: " + user1.getUsername() + " followed " + user2.getUsername());
            } else {
                message = fd.deleteFollowers(user1.getUsername(), user2.getUsername());

                if(message.equals("Done")) {
                    user1.setFollowingCount(user1.getFollowingCount()-1);
                    user2.setFollowersCount(user2.getFollowersCount()-1);
                }
                session.setAttribute("isFollowing", false);
                System.out.println("Log ::::: " + user1.getUsername() + " unfollowed " + user2.getUsername());
            }
            
            UserDAO ud = new UserDAO();
            ud.updateUser(user2);
            ud.updateUser(user1);
            
            String outString = "{\"isFollowing\": "+ !isFollowing +", \"followersCount\": "+ user2.getFollowersCount() +"}";
            
            out.print(outString);
            out.flush();
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
