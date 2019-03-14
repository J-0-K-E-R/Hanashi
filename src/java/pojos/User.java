/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pojos;

/**
 *
 * @author Joker
 */
public class User {

	private int Id;
	private String Username;
	private String Password;
	private String Email;
	private int FollowersCount;
	private int FollowingCount;
	private int FollowingTagsCount;
	private int Points;
	
	/**
	 * Constructor
	 * @param Username  the unique user's username
	 * @param Password      the password associated with the account
          * @param Email            the Email associated with the account
	 */
	public User(String Username, String Password, String Email) {
            this.Username = Username;
            this.Password = Password;
            this.Email = Email;
            this.FollowersCount = 0;
            this.FollowingCount = 0;
            this.FollowingTagsCount = 0;
            this.Points = 1;
	}

        public User(int Id, String Username, String Password, String Email, int FollowersCount, int FollowingCount, int FollowingTagsCount, int Points) {
            this.Id=Id;
            this.Username = Username;
            this.Password = Password;
            this.Email = Email;
            this.FollowersCount = FollowersCount;
            this.FollowingCount = FollowingCount;
            this.FollowingTagsCount = FollowingTagsCount;
            this.Points = Points;
        }
	/**
	 * Return the id
	 */
	public int getId() {
		return Id;
	}

	/**
	 * Set a new id
	 */
	public void setId(int Id) {
		this.Id = Id;
	}

	/**
	 * Return the username
	 */
	public String getUsername() {
		return Username;
	}

	/**
	 * Set a new username
	 */
	public void setUsername(String Username) {
		this.Username = Username;
	}

	/**
	 * Return the user's password
	 */
	public String getPassword() {
		return Password;
	}

	/**
	 * Set a new password
	 */
	public void setPassword(String Password) {
		this.Password = Password;
	}

	/**
	 * Return the user's Email
	 */
	public String getEmail() {
		return Email;
	}

	/**
	 * Set a new Email
	 */
	public void setEmail(String Email) {
		this.Email = Email;
	}

	/**
	 * Return the user's FollowersCount
	 */
	public int getFollowersCount() {
		return FollowersCount;
	}

	/**
	 * Set a new FollowerCount
	 */
	public void setFollowersCount(int FollowersCount) {
		this.FollowersCount = FollowersCount;
	}

	/**
	 * Return the user's FollowingCount
	 */
	public int getFollowingCount() {
		return FollowingCount;
	}

	/**
	 * Set a new FollowingCount
	 */
	public void setFollowingCount(int FollowingCount) {
		this.FollowingCount = FollowingCount;
	}

	/**
	 * Return the user's FollowingTagsCount
	 */
	public int getFollowingTagsCount() {
		return FollowingTagsCount;
	}

	/**
	 * Set a new FollowingTagsCount
	 */
	public void setFollowingTagsCount(int FollowingTagsCount) {
		this.FollowingTagsCount = FollowingTagsCount;
	}

	/**
	 * Return the user's points
	 */
	public int getPoints() {
		return Points;
	}

	/**
	 * Set a new points
	 */
	public void setPoints(int Points) {
		this.Points = Points;
	}
}
