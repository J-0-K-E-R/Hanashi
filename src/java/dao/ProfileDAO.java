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
import pojos.User;

/**
 *
 * @author Joker
 */
public class ProfileDAO {
    private PreparedStatement fetchUserStatement;
    
    
    public User fetchUser(String username) {
        User user = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

            //Create the prepfetchUserStatementaredstatement(s)
            fetchUserStatement = conn.prepareStatement("select * from users where Username=?");
        } catch (Exception e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        try {
            //Add parameters to the ?'s in the preparedstatement and execute
            fetchUserStatement.setString(1, username);
            ResultSet rs = fetchUserStatement.executeQuery();

            //if we've returned a row, turn that row into a new user object
            if (rs.next()) {
                user = new User(rs.getInt("ID"), rs.getString("Username"), rs.getString("Password"), rs.getString("Email"), rs.getInt("FollowersCount"), rs.getInt("FollowingCount"), rs.getInt("FollowingTagsCount"), rs.getInt("Points"));
            }
        } catch (SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return user;
    }
}
