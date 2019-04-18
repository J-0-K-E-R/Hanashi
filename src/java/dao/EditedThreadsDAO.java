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
public class EditedThreadsDAO {
    
    private static PreparedStatement updateEditedThreadStatement;
    
    public static void updateThreadByMod(pojos.Thread thread, String username, String comment) {
        Connection conn = null;
        Timestamp modified = new Timestamp(thread.getTimestampModified().getTime().getTime());
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            System.out.println("Log:::: EditedThreadDAO.editThreadByMod");
            
            //Create the preparedstatement(s)
            if(!doesExist(thread.getThreadID())){
                updateEditedThreadStatement = conn.prepareStatement("insert into edited_threads values(?, ?, ?, null)");
            
                //Add parameters to the ?'s in the preparedstatement and execute
                updateEditedThreadStatement.setInt(1, thread.getThreadID());
                updateEditedThreadStatement.setString(2, username);
                updateEditedThreadStatement.setString(3, comment);
            }
            else{
                updateEditedThreadStatement = conn.prepareStatement("update edited_threads set " 
                    + "Username = ?,"
                    + "Comment = ? ,"
                    + "Timestamp_Modified = ? "
                    + "where Thread_ID = ?");
            
                //Add parameters to the ?'s in the preparedstatement and execute
                updateEditedThreadStatement.setString(1, username);
                updateEditedThreadStatement.setString(2, comment);
                updateEditedThreadStatement.setTimestamp(3, modified);
                updateEditedThreadStatement.setInt(4, thread.getThreadID());
            }
            updateEditedThreadStatement.executeUpdate();
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateEditedThreadStatement);
            DBUtil.close(conn);
        }
    }
    
    
    public static boolean doesExist(int threadID) {
        boolean result = false;
        Connection conn = null;
        ResultSet rs = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            updateEditedThreadStatement = conn.prepareStatement("select * from edited_threads where Thread_ID = ?");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            updateEditedThreadStatement.setInt(1, threadID);
            rs = updateEditedThreadStatement.executeQuery();
            if(rs.next())
                result = true;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateEditedThreadStatement);
            DBUtil.close(rs);
            DBUtil.close(conn);
        }
        return result;
    }
}
