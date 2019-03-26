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
import java.util.logging.Level;
import java.util.logging.Logger;
import utilities.TagsService;

/**
 *
 * @author robogod
 */
public class TagsDAO {
    private PreparedStatement updateTagsStatement;
    
    public String updateTags(String tagsList) {
        String message="";
        ArrayList<String> tags = TagsService.tagsToArrayList(tagsList);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            for(String tag: tags) {
                if(doesExist(tag)) 
                    updateTagsStatement = conn.prepareStatement("update tags set count = count + 1 where tag=?");
                else 
                    updateTagsStatement = conn.prepareStatement("insert into tags(tag) values(?)");
                
                updateTagsStatement.setString(1, tag);
                updateTagsStatement.executeUpdate();
                message="Done";
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
            message = ex.getMessage();
        }
        
        return message;
    }
    
    public boolean doesExist(String tag) {
        boolean answer = false;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            PreparedStatement fetchResult = conn.prepareStatement("SELECT * FROM tags WHERE tag=?;");
            fetchResult.setString(1, tag);
            
            ResultSet rs = fetchResult.executeQuery();
            if(rs.next()) {
                answer = true;
            }
        }
        catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
        }
        return answer;
    }
    
}
