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
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
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
    private PreparedStatement updateVariableStatement;
    
    public Thread addNewThread(Thread thread) {
        int tid = -1;
        Thread returnThread = null;
        Connection conn = null;
        ResultSet rs = null;
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
                        
            fetchThreadIDStatement = conn.prepareStatement("SELECT MAX(Thread_ID) from threads;");
            
            rs = fetchThreadIDStatement.executeQuery();
            rs.next();
            tid = rs.getInt(1);
            
            returnThread = this.fetchThread(tid);//thread.getThreadID());
            
            addProcessedThread(returnThread);
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
            
            fetchThreadIDStatement = conn.prepareStatement("SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'hanashi' AND TABLE_NAME = 'threads';");
            
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
    
    public int getNewThreadID() {
        int tid = -1;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchThreadIDStatement = conn.prepareStatement("SELECT MAX(Thread_ID) from threads;");
            
            rs = fetchThreadIDStatement.executeQuery();
            if(rs.next()) {
                tid = rs.getInt("Thread_ID");
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
            
            fetchThreadIDStatement = conn.prepareStatement("select * from threads where Thread_ID=? and visible=TRUE");
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
            
            fetchThreadsStatement = conn.prepareStatement("select * from threads where visible=TRUE order by Votes desc limit 50");
            
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
            
            fetchThreadsStatement = conn.prepareStatement("select * from threads where visible=TRUE order by "+sortby+" desc limit 50");
            
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
            
            fetchUserThreadsStatement = conn.prepareStatement("select * from threads where username=? and visible=TRUE order by Timestamp_Modified desc");
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
    
    public Thread updateThreadByMod(Thread thread, String username, String comment) {
        Thread returnThread = null;
        Connection conn = null;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            System.out.println("Log:::: ThreadDAO.editThreadByMod");
            
            //Create the preparedstatement(s)
            updateThreadStatement = conn.prepareStatement("update  threads set " 
                    + "Title = ?,"
                    + "Post = ?,"
                    + "Tags_List = ? where Thread_ID = ?");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            updateThreadStatement.setString(1, thread.getTitle());
            updateThreadStatement.setString(2, thread.getPost());
            updateThreadStatement.setString(3, thread.getTagsList());
            updateThreadStatement.setInt(4, thread.getThreadID());
            updateThreadStatement.executeUpdate();
            returnThread = this.fetchThread(thread.getThreadID());
            updateProcessedThread(returnThread);
            
            EditedThreadsDAO.updateThreadByMod(thread, username, comment);
            
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
            createThreadStatement.setString(2, Preprocess.preprocess(thread.getTitle()));
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
            updateThreadStatement.setString(1, Preprocess.preprocess(thread.getTitle()));
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
    
    public ArrayList<Integer> fetchThreadIDs(String query) {
        ArrayList<Integer> threadIDs = new ArrayList<>();
        Connection conn = null;
        ResultSet rs = null;
        query = Preprocess.preprocess(query);
        System.out.println("Log :::: Search Query: " + query);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            updateVariableStatement = conn.prepareStatement("SET @query:=?;");
            updateVariableStatement.setString(1, query);
            updateVariableStatement.execute();
            
            fetchThreadIDStatement = conn.prepareStatement("" +
                    "SELECT " +
                    "pt.thread_id, " +
                    "sum(MATCH(pt.post) AGAINST(@query)) as pt_post_score, " +
                    "sum(MATCH(pt.title) AGAINST(@query)) as pt_title_score, " +
                    "sum(MATCH(pt.tags_list) AGAINST(@query)) as pt_tag_score, " +
                    "sum(MATCH(pp.post) AGAINST(@query)) as pp_post_score " +
                    "FROM processed_posts pp " +
                    "RIGHT JOIN processed_threads pt " +
                    "ON pp.thread_id = pt.thread_id " +
                    "WHERE " +
                    "(MATCH(pt.post) AGAINST(@query))  " +
                    "OR (MATCH(pt.title) AGAINST(@query)) " +
                    "OR (MATCH(pt.tags_list) AGAINST(@query)) " +
                    "OR (MATCH(pp.post) AGAINST(@query)) " +
                    "GROUP BY pt.thread_id " +
                    "ORDER BY " +
                    "(sum(MATCH(pt.post) AGAINST(@query)) " +
                    "+ sum(MATCH(pt.title) AGAINST(@query)) " +
                    "+ sum(MATCH(pt.tags_list) AGAINST(@query)) " +
                    "+ sum(MATCH(pp.post) AGAINST(@query))) DESC;");
            
            rs = fetchThreadIDStatement.executeQuery();
            while(rs.next()) {
                threadIDs.add(rs.getInt("Thread_ID"));
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchThreadIDStatement);
            DBUtil.close(updateVariableStatement);
            DBUtil.close(conn);
        }
        return threadIDs;
    }
    
    public ArrayList<Thread> search(String query) {
        ArrayList<Thread> threads = new ArrayList<>();
        ArrayList<Integer> tids = fetchThreadIDs(query);
        
        tids.forEach((tid) -> {
            threads.add(fetchThread(tid));
        });
        
        return threads;
    }
    
    public ArrayList<Integer> fetchUserThreadIDs(String username) {
        ArrayList<Integer> threads = new ArrayList<>();
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchUserThreadsStatement = conn.prepareStatement("select thread_id from threads where username=? and visible=TRUE order by Timestamp_Modified desc");
            fetchUserThreadsStatement.setString(1, username);
            rs = fetchUserThreadsStatement.executeQuery();
            while(rs.next()) {
                threads.add(rs.getInt("Thread_ID"));
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
    
    public ArrayList<Thread> fetchRelevantThreads(String username) {
        ArrayList<Thread> relevantThreads = new ArrayList<>();
        
        dao.TagsFollowersDAO tfd = new dao.TagsFollowersDAO();
        String search_query = tfd.fetchTags(username);
        
        ArrayList<Integer> tids = fetchThreadIDs(search_query);
        
        FollowersDAO fd = new FollowersDAO();
        ArrayList<pojos.User> followingList = fd.getFollowing(username);
        
        PostDAO pd = new PostDAO();
        
        followingList.forEach((user) -> { 
            tids.addAll(fetchUserThreadIDs(user.getUsername()));
            tids.addAll(pd.fetchUserThreadIDs(user.getUsername()));
        });

        
        HashSet<Integer> allIds = new HashSet<>(tids);
        
        Thread tempThread;
        for(int threadID: allIds) {
            tempThread = fetchThread(threadID);
            if(tempThread != null)
                relevantThreads.add(tempThread);
        }
        
        
        // sort by Timestamp_Modified
        Collections.sort(relevantThreads, new Comparator<pojos.Thread>() {
            @Override
            public int compare(pojos.Thread o1, pojos.Thread o2) {
                return o1.getTimestampModified().compareTo(o2.getTimestampModified());
            }
        }.reversed());
        
        return relevantThreads;
    }
    
    public String deleteThread(int threadID) {
        String message = "";
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            updateThreadStatement = conn.prepareStatement("update threads set visible=FALSE where Thread_ID=?");
            updateThreadStatement.setInt(1, threadID);
            
            updateThreadStatement.executeUpdate();
            message = "Done";
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getClass().getName();
        } finally {
            DBUtil.close(updateThreadStatement);
            DBUtil.close(conn);
        }
        return message;
    }
}
