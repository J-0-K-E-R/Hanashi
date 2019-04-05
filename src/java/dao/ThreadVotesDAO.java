/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author robogod
 */
public class ThreadVotesDAO {
    private static PreparedStatement insertStatement;
    
    public static String voteThread(int threadID, String username,  int vote) {
        String message;
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                insertStatement = conn.prepareStatement("insert into thread_votes values(?, ?, ?) ");
                insertStatement.setInt(1, threadID);
                insertStatement.setString(2, username);
                insertStatement.setInt(3, vote);
                insertStatement.executeUpdate();
                message = "Done";
            } catch (SQLException | ClassNotFoundException e) {
                    System.out.println(e.getClass().getName() + ": " + e.getMessage());
                    message = e.getMessage();
            }
        return message;
    }
}
