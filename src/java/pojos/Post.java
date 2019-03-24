/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pojos;

import java.util.Calendar;

/**
 *
 * @author robogod
 */
public class Post {
    private int postID;
    private int threadID;
    private String post;
    private String username;
    private int votes;
    private Calendar timestampCreated;
    private Calendar timestampModified;
    private String replyTo;

    
    public Post() {
        this.threadID = 0;
        this.votes = 0;
        this.timestampCreated = Calendar.getInstance();
        this.timestampModified = Calendar.getInstance();
    }
    
    public Post(int postID, int threadID, String post, String username, int votes, String replyTo) {
        this.postID = postID;
        this.threadID = threadID;
        this.post = post;
        this.username = username;
        this.votes = votes;
        this.timestampCreated = Calendar.getInstance();
        this.timestampModified = Calendar.getInstance();
        this.replyTo = replyTo;
    }    
    
    
    /**
     * @return the postID
     */
    public int getPostID() {
        return postID;
    }

    /**
     * @param postID the postID to set
     */
    public void setPostID(int postID) {
        this.postID = postID;
    }

    /**
     * @return the threadID
     */
    public int getThreadID() {
        return threadID;
    }

    /**
     * @param threadID the threadID to set
     */
    public void setThreadID(int threadID) {
        this.threadID = threadID;
    }

    /**
     * @return the post
     */
    public String getPost() {
        return post;
    }

    /**
     * @param post the post to set
     */
    public void setPost(String post) {
        this.post = post;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the votes
     */
    public int getVotes() {
        return votes;
    }

    /**
     * @param votes the votes to set
     */
    public void setVotes(int votes) {
        this.votes = votes;
    }

    /**
     * @return the timestampCreated
     */
    public Calendar getTimestampCreated() {
        return timestampCreated;
    }

    /**
     * @param timestampCreated the timestampCreated to set
     */
    public void setTimestampCreated(Calendar timestampCreated) {
        this.timestampCreated = timestampCreated;
    }
    
    public void setTimestampCreated(long timestampCreated) {
        this.timestampCreated.setTimeInMillis(timestampCreated);
    }


    /**
     * @return the timestampModified
     */
    public Calendar getTimestampModified() {
        return timestampModified;
    }

    /**
     * @param timestampModified the timestampModified to set
     */
    public void setTimestampModified(Calendar timestampModified) {
        this.timestampModified = timestampModified;
    }
    
    public void setTimestampModified(long timestampModified) {
        this.timestampModified.setTimeInMillis(timestampModified);
    }

    /**
     * @return the replyTo
     */
    public String getReplyTo() {
        return replyTo;
    }

    /**
     * @param replyTo the replyTo to set
     */
    public void setReplyTo(String replyTo) {
        this.replyTo = replyTo;
    }

}
