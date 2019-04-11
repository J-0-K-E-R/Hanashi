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
 * @author Joker
 */
public class FollowersDAO {
    private PreparedStatement insertStatement, queryStatement, deleteStatement;
    
    public String addFollowers(String user1, String user2) {
        String message = "";
        Connection conn = null;
        
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                insertStatement = conn.prepareStatement("insert into followers values(?, ?)");
                insertStatement.setString(1, user1);
                insertStatement.setString(2, user2);
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
    
    public String deleteFollowers(String user1, String user2) {
        String message = "";
        Connection conn = null;
        
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                deleteStatement = conn.prepareStatement("delete from followers where Username1=? and Username2=?");
                deleteStatement.setString(1, user1);
                deleteStatement.setString(2, user2);
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
    
    public boolean isFollowing(String user1, String user2) {
        boolean message = false;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                queryStatement = conn.prepareStatement("select * from followers where Username1=? and Username2=?");
                queryStatement.setString(1, user1);
                queryStatement.setString(2, user2);
                rs = queryStatement.executeQuery();
                if(rs.next()) {
                    message = true;
                }
            } catch (SQLException | ClassNotFoundException e) {
                    System.out.println(e.getClass().getName() + ": " + e.getMessage());
            } finally {
                DBUtil.close(rs);
                DBUtil.close(queryStatement);
                DBUtil.close(conn);
            }
        
        return message;
    }
}
