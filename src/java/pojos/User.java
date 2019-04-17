/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/
package pojos;

import java.io.Serializable;

/**
 *
 * @author Joker
 */
public class User implements Serializable {
    
    private int id;
    private String username;
    private String password;
    private String email;
    private int followersCount;
    private int followingCount;
    private int followingTagsCount;
    private int points;
    private String avatarPath;
    private int privilege;
    
    /**
     * Constructor
     * @param Username  the unique user's username
     * @param Password      the password associated with the account
     * @param Email            the Email associated with the account
     */
    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.followersCount = 0;
        this.followingCount = 0;
        this.followingTagsCount = 0;
        this.points = 1;
        this.avatarPath = "/Hanashi/user.png";
    }
    
    public User(int id, String username, String password, String email, int followersCount, int followingCount, int followingTagsCount, int points, String avatarPath, int privilege) {
        this.id=id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.followersCount = followersCount;
        this.followingCount = followingCount;
        this.followingTagsCount = followingTagsCount;
        this.points = points;
        this.avatarPath = avatarPath;
        this.privilege = privilege;
    }
    
    /**
     * @return the id
     */
    public int getId() {
        return id;
    }
    
    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
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
     * @return the password
     */
    public String getPassword() {
        return password;
    }
    
    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }
    
    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }
    
    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }
    
    /**
     * @return the followersCount
     */
    public int getFollowersCount() {
        return followersCount;
    }
    
    /**
     * @param followersCount the followersCount to set
     */
    public void setFollowersCount(int followersCount) {
        this.followersCount = followersCount;
    }
    
    /**
     * @return the followingCount
     */
    public int getFollowingCount() {
        return followingCount;
    }
    
    /**
     * @param followingCount the followingCount to set
     */
    public void setFollowingCount(int followingCount) {
        this.followingCount = followingCount;
    }
    
    /**
     * @return the followingTagsCount
     */
    public int getFollowingTagsCount() {
        return followingTagsCount;
    }
    
    /**
     * @param followingTagsCount the followingTagsCount to set
     */
    public void setFollowingTagsCount(int followingTagsCount) {
        this.followingTagsCount = followingTagsCount;
    }
    
    /**
     * @return the points
     */
    public int getPoints() {
        return points;
    }
    
    /**
     * @param points the points to set
     */
    public void setPoints(int points) {
        this.points = points;
    }
    
    /**
     * @return the avatarPath
     */
    public String getAvatarPath() {
        return avatarPath;
    }
    
    /**
     * @param avatarPath the avatarPath to set
     */
    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }
    
    /**
     * @return the privilege
     */
    public int getPrivilege() {
        return privilege;
    }
    
    /**
     * @param privilege the privilege to set
     */
    public void setPrivilege(int privilege) {
        this.privilege = privilege;
    }
    
}
