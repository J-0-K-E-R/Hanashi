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
import pojos.Tag;
import utilities.DBUtil;
import utilities.TagsService;

/**
 *
 * @author robogod
 */
public class TagsDAO {
    private PreparedStatement updateTagsStatement;
    private PreparedStatement deleteTagsStatement;
    
    public String updateTags(String tagsList) {
        String message="";
        ArrayList<String> tags = TagsService.tagsToArrayList(tagsList);
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
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
        } finally {
            DBUtil.close(updateTagsStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public boolean doesExist(String tag) {
        boolean answer = false;
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement fetchResult = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchResult = conn.prepareStatement("SELECT * FROM tags WHERE tag=?;");
            fetchResult.setString(1, tag);
            
            rs = fetchResult.executeQuery();
            if(rs.next()) {
                answer = true;
            }
        }
        catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchResult);
            DBUtil.close(conn);
        }
        
        return answer;
    }
    public String deleteTags(String tagsList) {
        String message="";
        ArrayList<String> tags = TagsService.tagsToArrayList(tagsList);
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            for(String tag: tags) {
                if(doesExist(tag)) {
                    deleteTagsStatement = conn.prepareStatement("update tags set count = count - 1 where tag=?");
                    deleteTagsStatement.setString(1, tag);
                    deleteTagsStatement.executeUpdate();
                    this.removeZeroTags();
                }
            }
            message="Done";
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
            message = ex.getMessage();
        } finally {
            DBUtil.close(deleteTagsStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    public String removeZeroTags() {
        String message="";
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            deleteTagsStatement = conn.prepareStatement("delete from tags where count = 0");
            deleteTagsStatement.executeUpdate();
            message="Done";
        } 
        catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
            message = ex.getMessage();
        } finally {
            DBUtil.close(deleteTagsStatement);
            DBUtil.close(conn);
        }
        
        return message;
    }
    
    public ArrayList<Tag> fetchTags() {
        ArrayList<Tag> tagsList = new ArrayList();
        Tag tag;
        Connection conn = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            deleteTagsStatement = conn.prepareStatement("select * from tags order by count desc;");
            rs = deleteTagsStatement.executeQuery();
            while(rs.next()) {
                tag = new Tag();
                tag.setTag(rs.getString("tag"));
                tag.setCount(rs.getInt("count"));
                tagsList.add(tag);
            }
        } 
        catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getClass().getName() + ": " + ex.getMessage());
            tagsList = null;
        } finally {
            DBUtil.close(rs);
            DBUtil.close(deleteTagsStatement);
            DBUtil.close(conn);
        }
        
        return tagsList;
    }
}
