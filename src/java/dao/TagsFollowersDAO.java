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
public class TagsFollowersDAO {
    private PreparedStatement insertStatement;
    private PreparedStatement deleteStatement;
    
    public String addFollower(String tag, String username) {
        String message="";
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            insertStatement = conn.prepareStatement("insert into tags_followers values(?, ?)");            
            insertStatement.setString(1, tag);
            insertStatement.setString(2, username);
            insertStatement.executeUpdate();
            message="Done";
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
            message = ex.getMessage();
        } finally {
            DBUtil.close(insertStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public String removeFollower(String tag, String username) {
        String message="";
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            deleteStatement = conn.prepareStatement("delete from tags_followers where tag=? and username=?");            
            deleteStatement.setString(1, tag);
            deleteStatement.setString(2, username);
            deleteStatement.executeUpdate();
            message="Done";
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
            message = ex.getMessage();
        } finally {
            DBUtil.close(deleteStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public boolean doesExist(String tag, String username) {
        boolean answer = false;
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement fetchResult = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchResult = conn.prepareStatement("SELECT * FROM tags_followers WHERE tag=? and username=?;");
            fetchResult.setString(1, tag);
            fetchResult.setString(2, username);
            
            rs = fetchResult.executeQuery();
            if(rs.next()) {
                answer = true;
            }
        }
        catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchResult);
            DBUtil.close(conn);
        }
        
        return answer;
    }
    
    public String fetchTags(String username) {
        String tags = "";
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement fetchResult = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchResult = conn.prepareStatement("SELECT tag FROM tags_followers WHERE username=?;");
            fetchResult.setString(1, username);
            
            rs = fetchResult.executeQuery();
            while(rs.next()) {
                tags += rs.getString("tag") + " ";
            }
        }
        catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchResult);
            DBUtil.close(conn);
        }
        
        return tags;
    }
}
