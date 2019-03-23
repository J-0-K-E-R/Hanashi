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
import java.util.logging.Level;
import java.util.logging.Logger;
import pojos.Thread;
import pojos.User;

/**
 *
 * @author robogod
 */
public class ThreadDAO {
    private PreparedStatement createThreadStatement;
    private PreparedStatement fetchThreadIDStatement;
    
    public Thread addNewThread(Thread thread) {
        Thread returnThread = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            createThreadStatement = conn.prepareStatement("insert into threads("
                    + "Title,"
                    + "Post,"
                    + "Tags_List,"
                    + "Username"
                    + ") values(?, ?, ?, ?)");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            createThreadStatement.setString(1, thread.getTitle());
            createThreadStatement.setString(2, thread.getPost());
            createThreadStatement.setString(3, thread.getTagsList());
            createThreadStatement.setString(4, thread.getUsername());
            createThreadStatement.executeUpdate();
            
            returnThread = this.fetchThread(thread.getThreadID());
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        
        return returnThread;
    }
    
    public int getNextThreadID() {
        int tid = -1;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchThreadIDStatement = conn.prepareStatement("SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'hanashi' AND   TABLE_NAME   = 'threads';");
            
            ResultSet rs = fetchThreadIDStatement.executeQuery();
            if(rs.next()) {
                tid = rs.getInt("AUTO_INCREMENT");
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return tid;
    }
    
    public Thread fetchThread(int threadID) {
        Thread thread = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchThreadIDStatement = conn.prepareStatement("select * from threads where Thread_ID=?");
            fetchThreadIDStatement.setInt(1, threadID);
            
            ResultSet rs = fetchThreadIDStatement.executeQuery();
            if(rs.next()) {
                thread = new Thread();
                thread.setThreadID(threadID);
                thread.setTitle(rs.getString("Title"));
                thread.setPost(rs.getString("Post"));
                thread.setTagsList(rs.getString("Tags_List"));
                thread.setUsername(rs.getString("Username"));
                thread.setVotes(rs.getInt("Votes"));
                thread.setTimestampCreated(rs.getLong("Timestamp_Created"));
                thread.setTimestampModified(rs.getLong("Timestamp_Modified"));
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return thread;
    }
}
