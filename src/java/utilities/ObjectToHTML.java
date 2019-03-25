/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.jasper.tagplugins.jstl.ForEach;
import pojos.Post;

/**
 *
 * @author robogod
 */
public class ObjectToHTML {
    
    public String resultSetToTable(ResultSet rs){
        String userList = "";
        try {
            userList = "<table>";
            String uname;
            while(rs.next()) {
                uname = rs.getString("Username");
                userList = userList.concat("<tr><td rowspan='2'><a href='/Hanashi/users/"+uname+"'>  Picture  </a></td>");
                userList = userList.concat("<td><a href='/Hanashi/users/"+uname+"'>"+uname+"</a></td></tr>");
                userList = userList.concat("<tr><td>"+rs.getInt("Points")+"</td></tr>");
            }
            userList = userList.concat("</table>");
        } catch (SQLException ex) {
            Logger.getLogger(ObjectToHTML.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }
    
    public String resultSetToTable(ResultSet rs, String tableClass, String trClass, String tdClass, String picClass){
        String userList = "";
        try {
            userList = "<table class='"+tableClass +"'>";
            String uname;
            while(rs.next()) {
                uname = rs.getString("Username");
                userList = userList.concat("<tr class='"+trClass +"'><td class='"+ tdClass + " " + picClass +"'rowspan='2'><a href='/Hanashi/users/"+uname+"'>  Picture  </a></td>");
                userList = userList.concat("<td class='"+tdClass +"'><a href='/Hanashi/users/"+uname+"'>"+rs.getString("Username")+"</a></td></tr>");
                userList = userList.concat("<tr class='"+trClass +"'><td class='"+tdClass +"'>"+rs.getInt("Points")+"</td></tr>");
            }
            userList = userList.concat("</table>");
        } catch (SQLException ex) {
            Logger.getLogger(ObjectToHTML.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }
    
    
    public String postsToHTML(ArrayList<Post> posts) {
        String out="";
        String temp;
        
        for(Post post: posts) {
            temp = "<div id='post-container'> <div id='user'>" + post.getUsername() + "</div>";
            temp = temp.concat("<div id='post-content'>"+post.getPost() + "</div>" + "<div id='timestamp'>" + post.getTimestampCreated().getTime() + "</div> </div>");
            out = out.concat(temp);
        }
        
        return out;
    }
    
}
