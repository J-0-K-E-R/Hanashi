/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilities.PasswordService;
import pojos.User;
import dao.UserDAO;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Joker
 */
@WebServlet(name = "signUpController", urlPatterns = {"/signUp"})
public class SignUpController extends HttpServlet {


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
            String username = request.getParameter("Username");
            String password = request.getParameter("Password");
            String email = request.getParameter("Email");
            
            PasswordService pwe = new PasswordService();
            
            //Encryption of new password
            String encryptPassword = pwe.encrypt(password);
            
            //Creating new user object
            User user = new User(username, encryptPassword, email);
            
            UserDAO ud = new UserDAO();
            
            //Entering information to DB
            String message = ud.signUpUser(user);
            
            if(message.equals("Done")) {
                request.setAttribute("Username", username);
                request.setAttribute("Password", password);
                RequestDispatcher rd = request.getRequestDispatcher("LogIn");
                rd.forward(request, response);
            }
            else {
                session.setAttribute("errorMessage", message);
                response.sendRedirect("SignUp.jsp");
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
