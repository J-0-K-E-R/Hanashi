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
public class UserReport {
    private int reportID;
    private String username;
    private String reportedBy;
    private String comment;
    private Calendar timestamp;
    
    
    public UserReport() {
        reportID = -1;
        username = "";
        reportedBy = "";
        comment = "";
        timestamp = Calendar.getInstance();
    }
    
    
    /**
     * @return the reportID
     */
    public int getReportID() {
        return reportID;
    }

    /**
     * @param reportID the reportID to set
     */
    public void setReportID(int reportID) {
        this.reportID = reportID;
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
     * @return the reportedBy
     */
    public String getReportedBy() {
        return reportedBy;
    }

    /**
     * @param reportedBy the reportedBy to set
     */
    public void setReportedBy(String reportedBy) {
        this.reportedBy = reportedBy;
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
    
    public void setTimestamp(long timeInMillis) {
        this.timestamp.setTimeInMillis(timeInMillis);
    }
    
}
