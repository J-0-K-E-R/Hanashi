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
        private PreparedStatement signUpUserStatement;
        private PreparedStatement checkEmail;
	
	/**
	 * Constructor which makes a connection
	 */
	public UserDAO() {
		
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
			//Set up connection
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
			
			//Create the preparedstatement(s)
			authenticateUserStatement = conn.prepareStatement("select * from users where Username=? and Password=?");
		} catch (Exception e) {
			System.out.println(e.getClass().getName() + ": " + e.getMessage());
		}
		try {
			//Add parameters to the ?'s in the preparedstatement and execute
			authenticateUserStatement.setString(1, username);
			authenticateUserStatement.setString(2, password);
			ResultSet rs = authenticateUserStatement.executeQuery();
			
			//if we've returned a row, turn that row into a new user object
			if (rs.next()) {
				user = new User(rs.getInt("ID"), rs.getString("Username"), rs.getString("Password"), rs.getString("Email"), rs.getInt("FollowersCount"), rs.getInt("FollowingCount"), rs.getInt("FollowingTagsCount"), rs.getInt("Points"));
			}
		} catch (SQLException e) {
			System.out.println(e.getClass().getName() + ": " + e.getMessage());
		}
		return user;
	}
        
        public String signUpUser(User user){
            String message="";
            try {
			//Set up connection
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
			
                        //Checking if Email already exists
                        checkEmail = conn.prepareStatement("select * from users where Email = ?");
                        checkEmail.setString(1, user.getEmail());
                        ResultSet rs = checkEmail.executeQuery();
			
			//if Email already exists
			if (rs.next()) {
                            message = "Email already exists";
			}
                        else{
                            //Create the preparedstatement(s)
                            signUpUserStatement = conn.prepareStatement("insert into users(Username, Password, Email) values(?, ?, ?)");
                            signUpUserStatement.setString(1, user.getUsername());
                            signUpUserStatement.setString(2, user.getPassword());
                            signUpUserStatement.setString(3, user.getEmail());
                            signUpUserStatement.executeUpdate();
                            message = "Done";
                        }
		}
                catch (Exception e) {
			System.out.println(e.getClass().getName() + ": " + e.getMessage());
		}
            
            return message;
        }
}
