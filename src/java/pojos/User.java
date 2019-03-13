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

	private int id;
	private String username;
	private String password;
	
	/**
	 * Constructor
	 * @param id  the unique user ID
	 * @param username  the unique user's username
	 * @param password	the password associated with the account
	 */
	public User(int id, String username, String password) {
		this.id = id;
		this.username = username;
		this.password = password;
	}

	/**
	 * Return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * Set a new id
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * Return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * Set a new username
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * Return the user's password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Set a new password
	 */
	public void setPassword(String password) {
		this.password = password;
	}
}
