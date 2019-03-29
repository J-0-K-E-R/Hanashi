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
import java.util.ArrayList;
import pojos.Post;

/**
 *
 * @author robogod
 */
public class PostDAO {
    private PreparedStatement createPostStatement;
    private PreparedStatement editPostStatement;
    private PreparedStatement fetchPostsStatement;
    
    public String addNewPost(Post post) {
        String message;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
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
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        }
        return message;
    }    
    
    public ArrayList<pojos.Post> fetchPosts(int threadID) {
        ArrayList<Post> posts = new ArrayList<>();
        Post post;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchPostsStatement = conn.prepareStatement("select * from posts where Thread_ID=?");
            fetchPostsStatement.setInt(1, threadID);
            
            ResultSet rs = fetchPostsStatement.executeQuery();
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
        }
        return posts;
    }

    public String updatePost(Post post) {       
        String message;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            //Create the preparedstatement(s)
            editPostStatement = conn.prepareStatement("update posts set "
                    + "Post = ?,"
                    + "Reply_to = ? "
                    + "where Post_ID=?;");
            
            
            editPostStatement.setString(1, post.getPost());
            editPostStatement.setString(2, post.getReplyTo());
            editPostStatement.setInt(3, post.getPostID());
            editPostStatement.executeUpdate();
            
            message = "Done";
            
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            message = e.getMessage();
        }
        return message;
    }
}
