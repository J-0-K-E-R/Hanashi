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
public class BannedUsersDAO {
    private static PreparedStatement insertStatement, queryStatement, deleteStatement;
    
    public static String ban(pojos.BanUser user) {
        String message = "";
        Connection conn = null;
        
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                insertStatement = conn.prepareStatement("insert into banned_users values(?,?,?,null);");
                insertStatement.setString(1, user.getUsername());
                insertStatement.setString(2, user.getBannedBy());
                insertStatement.setString(3, user.getComment());
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
    
    public static String unban(String username) {
        String message = "";
        Connection conn = null;
        
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                deleteStatement = conn.prepareStatement("delete from banned_users where Username=?");
                deleteStatement.setString(1, username);
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
    
    public static boolean isBanned(String username) {
        boolean message = false;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                queryStatement = conn.prepareStatement("select * from banned_users where Username=?");
                queryStatement.setString(1, username);
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
