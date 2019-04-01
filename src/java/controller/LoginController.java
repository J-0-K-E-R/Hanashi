/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/
package controller;


import dao.UserDAO;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pojos.User;
import utilities.PasswordService;
import java.io.PrintWriter;
import utilities.Recaptcha;

/**
 *
 * @author Joker
 */
@WebServlet(name = "LoginController", urlPatterns = {"/Login"})
public class LoginController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private HttpSession session;
    private String url;
    private static final String reCaptchaSecretKey = "6Lf9DJsUAAAAAL7SULc7Yg0tGeZAcXNbsb1h6Jo5";
    
    /**
     * Servlet constructor
     */
    public LoginController() {
        super();
    }
    
    /**
     * Process GET requests/responses (logout)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //User has clicked the logout link
        session = request.getSession();
        logout();
        
        url="/Hanashi/index.jsp";
        
        //forward our request along
        response.sendRedirect(url);
    }
    
    /**
     * Process POST requests/responses (login)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()){
            
            
            
            //get our current session
            session = request.getSession();
            
            //get the number of logins
            /*if(true){
            }
            else{*/	//proceed
            //pull the fields from the form
            String Username = request.getParameter("Username");
            String Password = request.getParameter("Password");
            
            //encrypt the password to check against what's stored in DB
            PasswordService pws = new PasswordService();
            String encryptedPass = pws.encrypt(Password);
            
            //create a user helper class to make database calls, and call authenticate user method
            UserDAO uh = new UserDAO();
            User user = uh.authenticateUser(Username, encryptedPass);
            
            //verify reCaptcha
            String reCaptchaResponse = request.getParameter("g-recaptcha-response");
            boolean verify = Recaptcha.verify(reCaptchaSecretKey, reCaptchaResponse);

            //we've found a user that matches the credentials
            if(user != null && verify){
                //invalidate current session, then get new session for our user (combats: session hijacking)
                url=(String)session.getAttribute("currentURI");
                session.invalidate();
                session=request.getSession(true);
                session.setAttribute("user", user);
                response.sendRedirect(url);
            }
            // user doesn't exist, redirect to previous page and show error
            else{
                String errorMessage;
                if(verify)
                    errorMessage = "Error: Unrecognized Username or Password";
                else
                    errorMessage = "You missed the reCAPTCHA";
                session.setAttribute("errorMessage", errorMessage);
                url = "/Hanashi/loginpage";
                response.sendRedirect(url);
            }
        }
    }
    
    /**
     * Logs the user out
     */
    public void logout() {
        session.setAttribute("user", null);
        session.removeAttribute("user");
        session.invalidate();
    }
}
