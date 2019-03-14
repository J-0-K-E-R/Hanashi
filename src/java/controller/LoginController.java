/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import DAO.UserDAO;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pojos.User;
import Utilities.PasswordService;
import java.io.PrintWriter;

/**
 *
 * @author Joker
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LogIn"})
public class LoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private HttpSession session; 
	private String url;

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
			url="index.jsp";

		//forward our request along
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
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
			//we've found a user that matches the credentials
			if(user != null){
				//invalidate current session, then get new session for our user (combats: session hijacking)
				session.invalidate();
				session=request.getSession(true);
				session.setAttribute("user", user);
				url="index.jsp";
			}
			// user doesn't exist, redirect to previous page and show error
			else{
				String errorMessage = "Error: Unrecognized Username or Password";
				request.setAttribute("errorMessage", errorMessage);
				url = "LogIn.jsp";
			}
		//forward our request along
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
            }
	}

	/**
	 * Logs the user out
	 */
	public void logout() {
		session.invalidate();
	}
}
