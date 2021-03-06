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
import pojos.Post;
import utilities.DBUtil;
import utilities.Preprocess;

/**
 *
 * @author robogod
 */
public class PostDAO {
    private PreparedStatement createPostStatement;
    private PreparedStatement editPostStatement;
    private PreparedStatement deletePostStatement;
    private PreparedStatement fetchPostsStatement;
    private PreparedStatement updateVotesStatement;
    private PreparedStatement fetchPostIDStatement;

    
    public String addNewPost(Post post) {
        String message;
        Connection conn = null;
        
        post.setPostID(getNextPostID());
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            createPostStatement = conn.prepareStatement("insert into posts("
                    + "Thread_ID,"
                    + "Post,"
                    + "Reply_to,"
                    + "Username"
                    + ") values(?, ?, ?, ?)");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            createPostStatement.setInt(1, post.getThreadID());
            createPostStatement.setString(2, post.getPost());
            createPostStatement.setString(3, post.getReplyTo());
            createPostStatement.setString(4, post.getUsername());
            createPostStatement.executeUpdate();
            
            message = "Done";
            addProcessedPost(post);
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        } finally {
            DBUtil.close(createPostStatement);
            DBUtil.close(conn);
        }
        return message;
    }

    public int getNextPostID() {
        int tid = -1;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchPostIDStatement = conn.prepareStatement("SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'hanashi' AND   TABLE_NAME   = 'posts';");
            
            rs = fetchPostIDStatement.executeQuery();
            if(rs.next()) {
                tid = rs.getInt("AUTO_INCREMENT");
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchPostIDStatement);
            DBUtil.close(conn);
        }
        return tid;
    }
    
    public ArrayList<pojos.Post> fetchPosts(int threadID) {
        ArrayList<Post> posts = new ArrayList<>();
        Post post;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchPostsStatement = conn.prepareStatement("select * from posts where Thread_ID=? and Reply_to is NULL and Visible=TRUE order by votes desc;");
            fetchPostsStatement.setInt(1, threadID);
            
            rs = fetchPostsStatement.executeQuery();
            while(rs.next()) {
                post = new Post();
                post.setThreadID(threadID);
                post.setPostID(rs.getInt("Post_ID"));
                post.setPost(rs.getString("Post"));
                post.setReplyTo(rs.getString("Reply_to"));
                post.setUsername(rs.getString("Username"));
                post.setVotes(rs.getInt("Votes"));
                post.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                post.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
                posts.add(post);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchPostsStatement);
            DBUtil.close(conn);
        }
        
        return posts;
    }
    
    public pojos.Post fetchPost(int postID) {
        Post post = null;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchPostsStatement = conn.prepareStatement("select * from posts where Post_ID=? and Visible=TRUE");
            fetchPostsStatement.setInt(1, postID);
            
            rs = fetchPostsStatement.executeQuery();
            if(rs.next()) {
                post = new Post();
                post.setThreadID(rs.getInt("Thread_ID"));
                post.setPostID(rs.getInt("Post_ID"));
                post.setPost(rs.getString("Post"));
                post.setReplyTo(rs.getString("Reply_to"));
                post.setUsername(rs.getString("Username"));
                post.setVotes(rs.getInt("Votes"));
                post.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                post.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchPostsStatement);
            DBUtil.close(conn);
        }
        
        return post;
    }

    public String updatePost(Post post) {       
        String message;
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            Timestamp modified = new Timestamp(post.getTimestampModified().getTime().getTime());

            
            //Create the preparedstatement(s)
            editPostStatement = conn.prepareStatement("update posts set "
                    + "Post = ?,"
                    + "Timestamp_Modified = ?"
                    + "where Post_ID=?;");
            
            
            editPostStatement.setString(1, post.getPost());
            editPostStatement.setTimestamp(2, modified);
            editPostStatement.setInt(3, post.getPostID());
            editPostStatement.executeUpdate();
            
            message = "Done";
            updateProcessedPost(post);
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        } finally {
            DBUtil.close(editPostStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public String updatePostByMod(Post post, String username, String comment) {       
        String message;
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

            
            //Create the preparedstatement(s)
            editPostStatement = conn.prepareStatement("update posts set "
                    + "Post = ? "
                    + "where Post_ID=?;");
            
            
            editPostStatement.setString(1, post.getPost());
            editPostStatement.setInt(2, post.getPostID());
            editPostStatement.executeUpdate();
            
            message = "Done";
            updateProcessedPost(post);
            
            EditedPostsDAO.updatePostByMod(post, username, comment);
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        } finally {
            DBUtil.close(editPostStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public void updatePostVotes(int postID, int votes) {
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            System.out.println("Log:::: PostDAO");
            //Create the preparedstatement(s)
            updateVotesStatement = conn.prepareStatement("update posts set votes = ? where Post_ID = ?");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            updateVotesStatement.setInt(1, votes);
            updateVotesStatement.setInt(2, postID);
            updateVotesStatement.executeUpdate();
            System.out.println("Log::: PostID: "+postID +" Votes: "+ votes);
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateVotesStatement);
            DBUtil.close(conn);
        }
    }
    
    public ArrayList<pojos.Post> fetchReplies(int postID) {
        ArrayList<Post> posts = new ArrayList<>();
        Post post;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchPostsStatement = conn.prepareStatement("select * from posts where Reply_to=? and Visible=TRUE");
            fetchPostsStatement.setString(1, String.valueOf(postID));
            
            rs = fetchPostsStatement.executeQuery();
            while(rs.next()) {
                post = new Post();
                post.setThreadID(rs.getInt("Thread_ID"));
                post.setPostID(rs.getInt("Post_ID"));
                post.setPost(rs.getString("Post"));
                post.setReplyTo(rs.getString("Reply_to"));
                post.setUsername(rs.getString("Username"));
                post.setVotes(rs.getInt("Votes"));
                post.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                post.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
                posts.add(post);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchPostsStatement);
            DBUtil.close(conn);
        }
        return posts;
    }
    
    public String addProcessedPost(Post post) {
        String message;
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            createPostStatement = conn.prepareStatement("insert into processed_posts("
                    + "Thread_ID,"
                    + "Post,"
                    + "Username,"
                    + "Post_ID"
                    + ") values(?, ?, ?, ?)");
            
            //Add parameters to the ?'s in the preparedstatement and execute
            createPostStatement.setInt(1, post.getThreadID());
            createPostStatement.setString(2, Preprocess.preprocess(Preprocess.htmlToText(post.getPost())));
            createPostStatement.setString(3, post.getUsername());
            createPostStatement.setInt(4, post.getPostID());
            createPostStatement.executeUpdate();
            
            message = "Done";
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        } finally {
            DBUtil.close(createPostStatement);
            DBUtil.close(conn);
        }
        return message;
    }    
    
    public String updateProcessedPost(Post post) {       
        String message;
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            
            //Create the preparedstatement(s)
            editPostStatement = conn.prepareStatement("update processed_posts set "
                    + "Post = ? "
                    + "where Post_ID=?;");
            
            
            editPostStatement.setString(1, Preprocess.preprocess(Preprocess.htmlToText(post.getPost())));
            editPostStatement.setInt(2, post.getPostID());
            editPostStatement.executeUpdate();
            
            message = "Done";
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        } finally {
            DBUtil.close(editPostStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public ArrayList<pojos.Post> fetchAllPosts() {
        ArrayList<Post> posts = new ArrayList<>();
        Post post;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchPostsStatement = conn.prepareStatement("select * from posts and Visible=TRUE;");
            
            rs = fetchPostsStatement.executeQuery();
            while(rs.next()) {
                post = new Post();
                post.setThreadID(rs.getInt("Thread_ID"));
                post.setPostID(rs.getInt("Post_ID"));
                post.setPost(rs.getString("Post"));
                post.setReplyTo(rs.getString("Reply_to"));
                post.setUsername(rs.getString("Username"));
                post.setVotes(rs.getInt("Votes"));
                post.setTimestampCreated(rs.getTimestamp("Timestamp_Created").getTime());
                post.setTimestampModified(rs.getTimestamp("Timestamp_Modified").getTime());
                posts.add(post);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchPostsStatement);
            DBUtil.close(conn);
        }
        
        return posts;
    }
    
        public String deletePost(int postID) {
        String message = "";
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            deletePostStatement = conn.prepareStatement("update posts set visible=FALSE where Post_ID=?");
            deletePostStatement.setInt(1, postID);
            
            deletePostStatement.executeUpdate();
            message = "Done";
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getClass().getName();
        } finally {
            DBUtil.close(deletePostStatement);
            DBUtil.close(conn);
        }
        return message;
    }
        
    public ArrayList<Integer> fetchUserThreadIDs(String username) {
        ArrayList<Integer> threads = new ArrayList<>();
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchPostsStatement = conn.prepareStatement("select thread_id from posts where username=? and visible=TRUE order by Timestamp_Modified desc");
            fetchPostsStatement.setString(1, username);
            rs = fetchPostsStatement.executeQuery();
            while(rs.next()) {
                threads.add(rs.getInt("Thread_ID"));
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchPostsStatement);
            DBUtil.close(conn);
        }
        return threads;
    }
}
