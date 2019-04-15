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
import java.util.ArrayList;
import pojos.Thread;

import utilities.DBUtil;
import utilities.Preprocess;

/**
 *
 * @author robogod
 */
public class ThreadDAO {
    private PreparedStatement createThreadStatement;
    private PreparedStatement updateThreadStatement;
    private PreparedStatement fetchThreadIDStatement;
    private PreparedStatement fetchThreadsStatement;
    private PreparedStatement fetchUserThreadsStatement;
    private PreparedStatement updateVotesStatement;
    
    public Thread addNewThread(Thread thread) {
        Thread returnThread = null;
        Connection conn = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
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
            addNewThread(returnThread);
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(createThreadStatement);
            DBUtil.close(conn);
        }
        
        return returnThread;
    }
    
    public int getNextThreadID() {
        int tid = -1;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchThreadIDStatement = conn.prepareStatement("SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'hanashi' AND   TABLE_NAME   = 'threads';");
            
            rs = fetchThreadIDStatement.executeQuery();
            if(rs.next()) {
                tid = rs.getInt("AUTO_INCREMENT");
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchThreadIDStatement);
            DBUtil.close(conn);
        }
        return tid;
    }
    
    public Thread fetchThread(int threadID) {
        Thread thread = null;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchThreadIDStatement = conn.prepareStatement("select * from threads where Thread_ID=?");
            fetchThreadIDStatement.setInt(1, threadID);
            
            rs = fetchThreadIDStatement.executeQuery();
            if(rs.next()) {
                thread = new Thread();
                thread.setThreadID(threadID);
                thread.setTitle(rs.getString("Title"));
                thread.setPost(rs.getString("Post"));
                thread.setTagsList(rs.getString("Tags_List"));
                thread.setUsername(rs.getString("Username"));
                thread.setVotes(rs.getInt("Votes"));
                thread.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                thread.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchThreadIDStatement);
            DBUtil.close(conn);
        }
        return thread;
    }
    
    public ArrayList<Thread> fetchAllThreads() {
        ArrayList<Thread> threads = new ArrayList<>();
        Thread thread;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchThreadsStatement = conn.prepareStatement("select * from threads order by Votes desc limit 50");
            
            rs = fetchThreadsStatement.executeQuery();
            while(rs.next()) {
                thread = new Thread();
                thread.setThreadID(rs.getInt("Thread_ID"));
                thread.setTitle(rs.getString("Title"));
                thread.setPost(rs.getString("Post"));
                thread.setTagsList(rs.getString("Tags_List"));
                thread.setUsername(rs.getString("Username"));
                thread.setVotes(rs.getInt("Votes"));
                thread.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                thread.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
                threads.add(thread);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchThreadsStatement);
            DBUtil.close(conn);
        }
        
        return threads;
    }
    
    public ArrayList<Thread> fetchAllThreads(String sortby) {
        ArrayList<Thread> threads = new ArrayList<>();
        Thread thread;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchThreadsStatement = conn.prepareStatement("select * from threads order by "+sortby+" desc limit 50");
            
            rs = fetchThreadsStatement.executeQuery();
            while(rs.next()) {
                thread = new Thread();
                thread.setThreadID(rs.getInt("Thread_ID"));
                thread.setTitle(rs.getString("Title"));
                thread.setPost(rs.getString("Post"));
                thread.setTagsList(rs.getString("Tags_List"));
                thread.setUsername(rs.getString("Username"));
                thread.setVotes(rs.getInt("Votes"));
                thread.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                thread.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
                threads.add(thread);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchThreadsStatement);
            DBUtil.close(conn);
        }
        
        return threads;
    }
    
     public ArrayList<Thread> fetchUserThreads(String profileUsername) {
        ArrayList<Thread> threads = new ArrayList<>();
        Thread thread;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchUserThreadsStatement = conn.prepareStatement("select * from threads where username=? order by Timestamp_Modified desc");
            fetchUserThreadsStatement.setString(1, profileUsername);
            rs = fetchUserThreadsStatement.executeQuery();
            while(rs.next()) {
                thread = new Thread();
                thread.setThreadID(rs.getInt("Thread_ID"));
                thread.setTitle(rs.getString("Title"));
//              thread.setPost(rs.getString("Post"));
                thread.setTagsList(rs.getString("Tags_List"));
                thread.setUsername(rs.getString("Username"));
                thread.setVotes(rs.getInt("Votes"));
                thread.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                thread.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
                threads.add(thread);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchUserThreadsStatement);
            DBUtil.close(conn);
        }
        return threads;
    }
    
    public Thread updateThread(Thread thread) {
        Thread returnThread = null;
        Connection conn = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            Timestamp modified = new Timestamp(thread.getTimestampModified().getTime().getTime());
            
            //Create the preparedstatement(s)
            updateThreadStatement = conn.prepareStatement("update  threads set " 
                    + "Title = ?,"
                    + "Post = ?,"
                    + "Timestamp_Modified = ?,"
                    + "Tags_List = ? where Thread_ID = ?");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            updateThreadStatement.setString(1, thread.getTitle());
            updateThreadStatement.setString(2, thread.getPost());
            updateThreadStatement.setTimestamp(3, modified);
            updateThreadStatement.setString(4, thread.getTagsList());
            updateThreadStatement.setInt(5, thread.getThreadID());
            updateThreadStatement.executeUpdate();
            returnThread = this.fetchThread(thread.getThreadID());
            updateProcessedThread(returnThread);
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateThreadStatement);
            DBUtil.close(conn);
        }
        
        return returnThread;
    }
    
    public void updateThreadVotes(int threadID, int votes) {
        Connection conn = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            System.out.println("Log:::: ThreadDAO");
            //Create the preparedstatement(s)
            updateVotesStatement = conn.prepareStatement("update threads set votes = ? where Thread_ID = ?");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            updateVotesStatement.setInt(1, votes);
            updateVotesStatement.setInt(2, threadID);
            updateVotesStatement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateVotesStatement);
            DBUtil.close(conn);
        }
    }
    
    
    
    /*
     * 
     * processed_threads operations
     *
     */
    
    
    public void addProcessedThread(Thread thread) {
        Connection conn = null;
        System.out.println("Log ::::: Adding processed Thread");
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            createThreadStatement = conn.prepareStatement("insert into processed_threads("
                    + "Thread_ID,"
                    + "Title,"
                    + "Post,"
                    + "Tags_List,"
                    + "Username"
                    + ") values(?, ?, ?, ?, ?)");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            
            createThreadStatement.setInt(1, thread.getThreadID());
            createThreadStatement.setString(2, thread.getTitle());
            createThreadStatement.setString(3, Preprocess.preprocess(Preprocess.htmlToText(thread.getPost())));
            createThreadStatement.setString(4, String.join(" ", thread.getTagsList().split(";")));
            createThreadStatement.setString(5, thread.getUsername());
            createThreadStatement.executeUpdate();
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(createThreadStatement);
            DBUtil.close(conn);
        }
    }
    
    public void updateProcessedThread(Thread thread) {
        Connection conn = null;
        System.out.println("Log ::::: Updating processed Thread");
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            updateThreadStatement = conn.prepareStatement("update  processed_threads set " 
                    + "Title = ?,"
                    + "Post = ?,"
                    + "Tags_List = ? where Thread_ID = ?");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            updateThreadStatement.setString(1, thread.getTitle());
            updateThreadStatement.setString(2, Preprocess.preprocess(Preprocess.htmlToText(thread.getPost())));
            updateThreadStatement.setString(3, String.join(" ", thread.getTagsList().split(";")));
            updateThreadStatement.setInt(4, thread.getThreadID());
            updateThreadStatement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateThreadStatement);
            DBUtil.close(conn);
        }
    }
}
