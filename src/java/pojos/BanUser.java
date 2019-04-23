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
public class BanUser {
    
    private String username;
    private String bannedBy;
    private String comment;
    private Calendar timestamp;
    
    public BanUser() {
        username = "";
        bannedBy = "";
        comment = "";
        timestamp = Calendar.getInstance();
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
     * @return the bannedBy
     */
    public String getBannedBy() {
        return bannedBy;
    }

    /**
     * @param bannedBy the bannedBy to set
     */
    public void setBannedBy(String bannedBy) {
        this.bannedBy = bannedBy;
    }

    /**
     * @return the comment
     */
    public String getComment() {
        return comment;
    }

    /**
     * @param comment the comment to set
     */
    public void setComment(String comment) {
        this.comment = comment;
    }

    /**
     * @return the timestamp
     */
    public Calendar getTimestamp() {
        return timestamp;
    }

    /**
     * @param timestamp the timestamp to set
     */
    public void setTimestamp(Calendar timestamp) {
        this.timestamp = timestamp;
    }
    
    public void setTimestamp(long mill) {
        this.timestamp.setTimeInMillis(mill);
    }
}
