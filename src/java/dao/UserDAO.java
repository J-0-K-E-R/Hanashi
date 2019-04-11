/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import pojos.User;
import utilities.DBUtil;
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
    private PreparedStatement fetchUserStatement;
    private PreparedStatement updateStatement;
    
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
        Connection conn = null;
        ResultSet rs = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            authenticateUserStatement = conn.prepareStatement("select * from users where Username=? and Password=?");
        } catch (Exception e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        try {
            //Add parameters to the ?'s in the preparedstatement and execute
            authenticateUserStatement.setString(1, username);
            authenticateUserStatement.setString(2, password);
            rs = authenticateUserStatement.executeQuery();
            
            //if we've returned a row, turn that row into a new user object
            if (rs.next()) {
                user = new User(rs.getInt("ID"), rs.getString("Username"), rs.getString("Password"), rs.getString("Email"), rs.getInt("FollowersCount"), rs.getInt("FollowingCount"), rs.getInt("FollowingTagsCount"), rs.getInt("Points"), rs.getString("AvatarPath"));
            }
        } catch (SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(authenticateUserStatement);
            DBUtil.close(conn);
        }
        return user;
    }
    
    public String signUpUser(User user){
        String message="";
        Connection conn = null;
        ResultSet rs = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Checking if Email already exists
            checkEmail = conn.prepareStatement("select * from users where Email = ?");
            checkEmail.setString(1, user.getEmail());
            rs = checkEmail.executeQuery();
            
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
        } finally {
            DBUtil.close(rs);
            DBUtil.close(signUpUserStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public User fetchUser(String username) {
        User user = null;
        Connection conn = null;
        ResultSet rs = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the prepfetchUserStatementaredstatement(s)
            fetchUserStatement = conn.prepareStatement("select * from users where Username=?");
        } catch (Exception e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        try {
            //Add parameters to the ?'s in the preparedstatement and execute
            fetchUserStatement.setString(1, username);
            rs = fetchUserStatement.executeQuery();
            
            //if we've returned a row, turn that row into a new user object
            if (rs.next()) {
                user = new User(rs.getInt("ID"), 
                        rs.getString("Username"), 
                        rs.getString("Password"), 
                        rs.getString("Email"),
                        rs.getInt("FollowersCount"), 
                        rs.getInt("FollowingCount"),
                        rs.getInt("FollowingTagsCount"), 
                        rs.getInt("Points"),
                        rs.getString("AvatarPath"));
            }
        } catch (SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchUserStatement);
            DBUtil.close(conn);
        }
        return user;
    }
    
    public String updateUser(User user) {
        String message="";
        Connection conn = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            updateStatement = conn.prepareStatement("update users set FollowersCount = ?, FollowingCount = ?, FollowingTagsCount = ?, Points = ? where Username = ?");
            updateStatement.setInt(1, user.getFollowersCount());
            updateStatement.setInt(2, user.getFollowingCount());
            updateStatement.setInt(3, user.getFollowingTagsCount());
            updateStatement.setInt(4, user.getPoints());
            updateStatement.setString(5, user.getUsername());
            updateStatement.executeUpdate();
            message = "Done";
        }
        catch (Exception e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public ArrayList<User> fetchUserList() {
        ArrayList<User> list = new ArrayList<>();
        User user = null;
        Connection conn = null;
        ResultSet rs = null;
        Statement fetchStatement = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            String fetchQuery = "select * from users order by Points desc";
            fetchStatement = conn.createStatement();
            rs = fetchStatement.executeQuery(fetchQuery);
            while(rs.next()) {
                user = new User(rs.getInt("ID"), 
                        rs.getString("Username"), 
                        rs.getString("Password"), 
                        rs.getString("Email"),
                        rs.getInt("FollowersCount"), 
                        rs.getInt("FollowingCount"),
                        rs.getInt("FollowingTagsCount"), 
                        rs.getInt("Points"),
                        rs.getString("AvatarPath"));
                list.add(user);
            }
            
            fetchStatement.close();
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            list = null;
        } finally {
            DBUtil.close(rs);
            DBUtil.close(conn);
        }
        return list;
    }
}
