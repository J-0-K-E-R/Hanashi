/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilities;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import java.util.Base64;

/**
 *
 * @author Joker
 *
 * This class converts plaintext password to a SHA256 hash.
 * 
 */
public final class PasswordService {

	/**Encrypt string pass to a hashed SHA256 encrypted version
	 */
        /**
	 * Constructor
	 * @param pass  the password associated with the account
	 * @return hash      returning the hash of password
	 */
	public String encrypt(String pass) {
		MessageDigest md = null;

		try {
			md = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		try {
			md.update(pass.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		byte raw[] = md.digest();
		String hash = new String(Base64.getMimeEncoder().encode(raw));
		return hash;
	}
}
