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
import java.sql.Timestamp;
import utilities.DBUtil;

/**
 *
 * @author robogod
 */
public class EditedPostsDAO {
    
    private static PreparedStatement updateStatement;
    private static PreparedStatement fetchStatement;
    
    public static void updatePostByMod(pojos.Post post, String username, String comment) {
        Connection conn = null;
        Timestamp modified = new Timestamp(post.getTimestampModified().getTime().getTime());
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            System.out.println("Log:::: EditedPostDAO.editPostByMod");
            
            //Create the preparedstatement(s)
            if(!doesExist(post.getPostID())){
                updateStatement = conn.prepareStatement("insert into edited_posts values(?, ?, ?, null)");
            
                //Add parameters to the ?'s in the preparedstatement and execute
                updateStatement.setInt(1, post.getPostID());
                updateStatement.setString(2, username);
                updateStatement.setString(3, comment);
            }
            else{
                updateStatement = conn.prepareStatement("update edited_posts set " 
                    + "Username = ?,"
                    + "Comment = ? ,"
                    + "Timestamp_Modified = ? "
                    + "where Post_ID = ?");
            
                //Add parameters to the ?'s in the preparedstatement and execute
                updateStatement.setString(1, username);
                updateStatement.setString(2, comment);
                updateStatement.setTimestamp(3, modified);
                updateStatement.setInt(4, post.getPostID());
            }
            updateStatement.executeUpdate();
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateStatement);
            DBUtil.close(conn);
        }
    }
    
    
    public static boolean doesExist(int postID) {
        boolean result = false;
        Connection conn = null;
        ResultSet rs = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            fetchStatement = conn.prepareStatement("select * from edited_posts where Post_ID = ?");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            fetchStatement.setInt(1, postID);
            rs = fetchStatement.executeQuery();
            if(rs.next())
                result = true;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(fetchStatement);
            DBUtil.close(rs);
            DBUtil.close(conn);
        }
        return result;
    }
}
