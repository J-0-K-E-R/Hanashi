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
public class PostDownvoteController extends HttpServlet {

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
            System.out.println("Log:::: PostVotes");
            
            pojos.User user = (pojos.User) session.getAttribute("user");
            dao.PostDAO pd = new dao.PostDAO();
            int postID = Integer.parseInt(request.getParameter("postID"));
            pojos.Post currentPost = pd.fetchPost(postID);
            UserDAO ud = new UserDAO();
            User currentPostUser = ud.fetchUser(currentPost.getUsername());
            
            String username =  user.getUsername();
            String message="";
            int retVal = -1;
            
            int doesExist = dao.PostVotesDAO.doesExist(postID, username);
            switch (doesExist) {
                case -1:
                    message =  dao.PostVotesDAO.removePostVote(postID, username); 
                    currentPost.setVotes(currentPost.getVotes()+1);
                    pd.updatePostVotes(postID, currentPost.getVotes());
                    retVal = 0;
                    
                    currentPostUser.setPoints(currentPostUser.getPoints()+Points.getPostDownvote());
                    user.setPoints(user.getPoints()+Points.getSelfDownvote());
                    break;
                case 1:
                    message =  dao.PostVotesDAO.votePost(postID, username , -1);
                    currentPost.setVotes(currentPost.getVotes()-2);
                    pd.updatePostVotes(postID, currentPost.getVotes());
                    
                    currentPostUser.setPoints(currentPostUser.getPoints()-Points.getPostDownvote()-Points.getPostUpvote());
                    user.setPoints(user.getPoints()-Points.getSelfDownvote());
                    break;
                default:
                    message =  dao.PostVotesDAO.votePost(postID, username , -1);
                    currentPost.setVotes(currentPost.getVotes()-1);
                    pd.updatePostVotes(currentPost.getPostID(), currentPost.getVotes());
                    
                    currentPostUser.setPoints(currentPostUser.getPoints()-Points.getPostDownvote());
                    user.setPoints(user.getPoints()-Points.getSelfDownvote());
                    break;
            }
            
            
            ud.updateUser(currentPostUser);
            ud.updateUser(user);
            
            out.write(currentPost.getVotes()+";"+retVal);
            
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
