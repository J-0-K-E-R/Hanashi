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
public class FollowersDAO {
    private PreparedStatement insertStatement;
    public String updateFollowers(String user1, String user2) throws ClassNotFoundException {
        String message = "";
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                insertStatement = conn.prepareStatement("insert into followers values(?, ?)");
                insertStatement.setString(1, user1);
                insertStatement.setString(2, user2);
                insertStatement.executeUpdate();
                message = "Done";
            } catch (SQLException e) {
                    System.out.println(e.getClass().getName() + ": " + e.getMessage());
            }
        return message;
    }
}
