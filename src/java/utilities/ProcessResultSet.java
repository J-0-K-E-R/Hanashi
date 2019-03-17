/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author robogod
 */
public class ProcessResultSet {
    
    public String resultSetToTable(ResultSet rs){
        String userList = "";
        try {
            userList = "<table>";
            while(rs.next()) {
                userList = userList.concat("<tr><td colspan='2'></td>");
                userList = userList.concat("<td>"+rs.getString("Username")+"</td></tr>");
                userList = userList.concat("<tr><td>"+rs.getInt("Points")+"</td></tr>");
            }
            userList = userList.concat("</table>");
        } catch (SQLException ex) {
            Logger.getLogger(ProcessResultSet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }
    
}
