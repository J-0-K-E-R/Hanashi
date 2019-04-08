/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.util.ArrayList;
import pojos.Post;
import pojos.Tag;
import pojos.Thread;
import pojos.User;

/**
 *
 * @author robogod
 */
public class ObjectToHTML {
    
    public String postsToHTML(ArrayList<Post> posts) {
        String out="";
        String temp;
        
        for(Post post: posts) {
            temp = "<div class=\"post-container\" id='" + post.getPostID() +"'>  <div id='user'>" + post.getUsername() + "</div>";
            temp = temp.concat("<div id='post-content'>"+post.getPost() + "</div>" + "<div id='timestamp'>" + utilities.DateService.relativeDate(post.getTimestampModified()) + "</div> </div>");
            
            out = out.concat(temp);
        }
        
        return out;
    }
    
    public String postsToHTML(ArrayList<Post> posts, String currentUser) {
        String out="";
        String temp;
        
        for(Post post: posts) {
            temp = "<div class=\"post-container\" id='" + post.getPostID() +"'>  <div id='user'>" + post.getUsername() + this.editTag(post.getPostID(), post.getUsername(), currentUser) + "</div>";
            temp = temp.concat("<div id='post-content'>"+post.getPost() + "</div>" + "<div id='timestamp'>" + utilities.DateService.relativeDate(post.getTimestampModified()) + "</div> </div>");
            
            temp = temp.concat("<div id='edit-" + post.getPostID() +"' hidden>"+ 
                    "<form action=\"/Hanashi/EditPost?editPostID="+ post.getPostID() +"\" id=\"create-post-form\" method=\"post\">\n" +
                    "<textarea id=\"froala-editor\" name=\"post-content\" required > "+post.getPost()+" </textarea> <br>\n" +
                    "<input class=\"btn btn-success\" type=\"submit\" value=\"Update\">\n" +
                    "<input type=\"button\" class=\"btn btn-default\" value=\"Cancel\" onclick=\"cancelEdit("+ post.getPostID() +");\">\n" +
                    "</form></div>");
            
            out = out.concat(temp);
        }
        
        return out;
    }
    
    public String threadsToHTML(ArrayList<Thread> threads) {
        String out="";
        String temp;
        
        for(Thread thread: threads) {
            temp = "<div id='thread-container'> <div id='votes'> Votes: " + thread.getVotes() + "</div>";
            temp = temp.concat("<div id='thread-title'> <a href='/Hanashi/threads/"+thread.getThreadID() + "'>"+thread.getTitle() + "</a></div>");
            temp = temp.concat("<div id='timestamp'>" + DateService.relativeDate(thread.getTimestampModified()) + "</div> </div>");
            out = out.concat(temp);
        }
        
        return out;
    }
    
    private String editTag (int postID, String user1, String user2) {
        String result = "";
        if(user1.equals(user2)){
            result = "<a id=\"userPostEdit\" href=\"#\" onclick=\"editUserPost("+ postID +");\"><span class=\"glyphicon glyphicon-edit\"></span></a>";
        }
        return result;
    }
    
    public String tagsListToHTML(ArrayList<Tag> tagsList) {
        String tags="";
        
        for(Tag tag: tagsList) {
            tags = tags.concat("<div class=\"tag-div\"> <a href=\"#\" class=\"tag-name\">"+tag.getTag() +"</a> "
                    + "<span class=\"tag-count-span\"> <span class=\"tag-count-x\"> x </span> "
                    + "<span class=\"tag-count\">"+tag.getCount()+"</span></span> </div>\n");
        }
        
        return tags;
    }
}
