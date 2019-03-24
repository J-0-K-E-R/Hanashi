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
public class Thread {
    private int threadID;
    private String title;
    private String post;
    private String tagsList;
    private String username;
    private int votes;
    private Calendar timestampCreated;
    private Calendar timestampModified;

    
    
    public Thread() {
        this.threadID = 0;
        this.votes = 0;
        this.timestampCreated = Calendar.getInstance();
        this.timestampModified = Calendar.getInstance();
    }
    
    public Thread(int threadID, String title, String post, String tagsList, String username, int votes) {
        this.threadID = threadID;
        this.title = title;
        this.post = post;
        this.tagsList = tagsList;
        this.username = username;
        this.votes = votes;
        this.timestampCreated = Calendar.getInstance();
        this.timestampModified = Calendar.getInstance();
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
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
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
     * @return the tagsList
     */
    public String getTagsList() {
        return tagsList;
    }

    /**
     * @param tagsList the tagsList to set
     */
    public void setTagsList(String tagsList) {
        this.tagsList = tagsList;
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
    public void setTimestampCreated(long timestampCreated) {
        this.timestampCreated.setTimeInMillis(timestampCreated);
    }
    
    public void setTimestampCreated(Calendar timestampCreated) {
        this.timestampCreated = timestampCreated;
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
    public void setTimestampModified(long timestampModified) {
        this.timestampModified.setTimeInMillis(timestampModified);
    }
    
    public void setTimestampModified(Calendar timestampModified) {
        this.timestampModified = timestampModified;
    }
    
    
    
}
