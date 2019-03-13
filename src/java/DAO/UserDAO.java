/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import pojos.User;
/**
 *
 * @author Joker
 *
 *
 * This class is used to insert, retrieve, and update users in the user table.
 */
public class UserDAO {
	
	/**
	 * Prepared SQL statement (combats: SQL Injections)
	 */
	private PreparedStatement authenticateUserStatement;
	
	/**
	 * Constructor which makes a connection
	 */
	public UserDAO() {
		try {
			//Set up connection
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/securelogin", "root", "");
			
			//Create the preparedstatement(s)
			authenticateUserStatement = conn.prepareStatement("select * from user where username=? and password=?");
		} catch (Exception e) {
			System.out.println(e.getClass().getName() + ": " + e.getMessage());
		}
	}
	
	/**
	 * Authenticates a user in the database.
	 * @param username  The username for the user.
	 * @param password  The password for the user.
	 * @return A user object if successful, null if unsuccessful.
	 */
	public User authenticateUser(String username, String password) {
		User user = null;
		try {
			//Add parameters to the ?'s in the preparedstatement and execute
			authenticateUserStatement.setString(1, username);
			authenticateUserStatement.setString(2, password);
			ResultSet rs = authenticateUserStatement.executeQuery();
			
			//if we've returned a row, turn that row into a new user object
			if (rs.next()) {
				user = new User(rs.getInt("userID"), rs.getString("username"), rs.getString("password"));
			}
		} catch (SQLException e) {
			System.out.println(e.getClass().getName() + ": " + e.getMessage());
		}
		return user;
	}
}
