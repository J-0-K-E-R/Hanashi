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

/**
 *
 * @author robogod
 */
public class ThreadVotesDAO {
    private static PreparedStatement insertStatement;
    private static PreparedStatement fetchStatement;
    private static PreparedStatement deleteStatement;
    
    public static String voteThread(int threadID, String username,  int vote) {
        String message;
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                if(doesExist(threadID, username) == 0)  {
                    insertStatement = conn.prepareStatement("insert into thread_votes values(?, ?, ?) ");
                    insertStatement.setInt(1, threadID);
                    insertStatement.setString(2, username);
                    insertStatement.setInt(3, vote);
                }
                else {
                    insertStatement = conn.prepareStatement("update thread_votes set vote = ? where username=? and thread_id = ?");
                    insertStatement.setInt(1, vote);
                    insertStatement.setString(2, username);
                    insertStatement.setInt(3, threadID);
                }
                
                insertStatement.executeUpdate();
                message = "Done";
            } catch (SQLException | ClassNotFoundException e) {
                    System.out.println(e.getClass().getName() + ": " + e.getMessage());
                    message = e.getMessage();
            }
        return message;
    }
    
    public static int doesExist(int threadID, String username) {
        int doesExist = 0;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            
            fetchStatement = conn.prepareStatement("select * from thread_votes where thread_id = ? and username = ? ");
            fetchStatement.setInt(1, threadID);
            fetchStatement.setString(2, username);
            ResultSet rs = fetchStatement.executeQuery();
            if(rs.next())
                doesExist = rs.getInt("vote");
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        
        return doesExist;
    }
    
    public static String removeThreadVote(int threadID, String username) {
        String message;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            
            deleteStatement = conn.prepareStatement("delete from thread_votes where thread_id = ? and username = ? ");
            deleteStatement.setInt(1, threadID);
            deleteStatement.setString(2, username);
            deleteStatement.executeUpdate();
            message = "Done";
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        }

        
        return message;
    }
}
