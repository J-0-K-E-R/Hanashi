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
public class ClosedThread {
    private int threadID;
    private String closedBy;
    private String comment;
    private Calendar timestamp;
    
    public ClosedThread() {
        this.threadID = -1;
        this.closedBy = "";
        this.comment = "";
        this.timestamp = Calendar.getInstance();
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
     * @return the closedBy
     */
    public String getClosedBy() {
        return closedBy;
    }

    /**
     * @param closedBy the closedBy to set
     */
    public void setClosedBy(String closedBy) {
        this.closedBy = closedBy;
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
    
    public void setTimestamp(long millis) {
        this.timestamp.setTimeInMillis(millis);
    }
    
    
}
