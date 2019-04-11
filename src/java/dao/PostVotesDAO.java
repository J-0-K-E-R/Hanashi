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
import utilities.DBUtil;

/**
 *
 * @author robogod
 */
public class PostVotesDAO {
    private static PreparedStatement insertStatement;
    private static PreparedStatement fetchStatement;
    private static PreparedStatement deleteStatement;
    
    public static String votePost(int postID, String username,  int vote) {
        String message;
        Connection conn = null;
        
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                if(doesExist(postID, username) == 0)  {
                    insertStatement = conn.prepareStatement("insert into post_votes values(?, ?, ?) ");
                    insertStatement.setInt(1, postID);
                    insertStatement.setString(2, username);
                    insertStatement.setInt(3, vote);
                }
                else {
                    insertStatement = conn.prepareStatement("update post_votes set vote = ? where username=? and post_id = ?");
                    insertStatement.setInt(1, vote);
                    insertStatement.setString(2, username);
                    insertStatement.setInt(3, postID);
                }
                
                insertStatement.executeUpdate();
                message = "Done";
            } catch (SQLException | ClassNotFoundException e) {
                    System.out.println(e.getClass().getName() + ": " + e.getMessage());
                    message = e.getMessage();
            } finally {
                DBUtil.close(insertStatement);
                DBUtil.close(conn);
            }
        
        return message;
    }
    
    public static int doesExist(int postID, String username) {
        int doesExist = 0;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            
            fetchStatement = conn.prepareStatement("select * from post_votes where post_id = ? and username = ? ");
            fetchStatement.setInt(1, postID);
            fetchStatement.setString(2, username);
            rs = fetchStatement.executeQuery();
            if(rs.next())
                doesExist = rs.getInt("vote");
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchStatement);
            DBUtil.close(conn);
        }
        
        return doesExist;
    }
    
    public static String removePostVote(int postID, String username) {
        String message;
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            
            deleteStatement = conn.prepareStatement("delete from post_votes where post_id = ? and username = ? ");
            deleteStatement.setInt(1, postID);
            deleteStatement.setString(2, username);
            deleteStatement.executeUpdate();
            message = "Done";
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        } finally {
            DBUtil.close(deleteStatement);
            DBUtil.close(conn);
        }

        
        return message;
    }
}
