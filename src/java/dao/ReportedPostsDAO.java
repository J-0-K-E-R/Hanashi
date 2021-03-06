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
import utilities.DBUtil;

/**
 *
 * @author robogod
 */
public class ReportedPostsDAO {
    private static PreparedStatement insertStatement, fetchStatement, updateStatement;
    
    public static pojos.PostReport report(pojos.PostReport report) {
        Connection conn = null;
        pojos.PostReport retReport;
        
        try {
                report.setReportID(getNextReportID());
                //Set up connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

                //Create the preparedstatement(s)
                insertStatement = conn.prepareStatement("insert into reported_posts values(null,?,?,?,null,null)");
                insertStatement.setInt(1, report.getPostID());
                insertStatement.setString(2, report.getReportedBy());
                insertStatement.setString(3, report.getComment());
                insertStatement.executeUpdate();
                
                retReport = report;
            } catch (SQLException | ClassNotFoundException e) {
                System.out.println(e.getClass().getName() + ": " + e.getMessage());
                retReport = null;
            } finally {
                DBUtil.close(insertStatement);
                DBUtil.close(conn);
            }
        
        return retReport;
    }
    
    public static int getNextReportID() {
        int tid = -1;
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchStatement = conn.prepareStatement("SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'hanashi' AND   TABLE_NAME   = 'reported_posts';");
            
            rs = fetchStatement.executeQuery();
            if(rs.next()) {
                tid = rs.getInt("AUTO_INCREMENT");
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchStatement);
            DBUtil.close(conn);
        }
        return tid;
    }
    
    public static ArrayList<pojos.PostReport> fetchReportedPosts() {
        ArrayList<pojos.PostReport> list = new ArrayList();
        pojos.PostReport report = new pojos.PostReport();
        Connection conn = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");
            
            fetchStatement = conn.prepareStatement("SELECT * FROM reported_posts where Addressed_By is NULL ORDER BY Timestamp DESC;");
            
            rs = fetchStatement.executeQuery();
            while(rs.next()) {
                report = new pojos.PostReport();
                report.setReportID(rs.getInt("Report_ID"));
                report.setPostID(rs.getInt("Post_ID"));
                report.setTimestamp(rs.getTimestamp("Timestamp").getTime());
                report.setComment(rs.getString("Comment"));
                report.setReportedBy(rs.getString("Reported_By"));
                list.add(report);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            list = null;
        } finally {
            DBUtil.close(rs);
            DBUtil.close(fetchStatement);
            DBUtil.close(conn);
        }
        return list;
    }
    
    public static void addressDeletedPost(int postID, String username) {
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

            //Create the preparedstatement(s)
            updateStatement = conn.prepareStatement("update reported_posts set Addressed_By = ? where Addressed_By is NULL and post_ID = ?");
            updateStatement.setString(1, username);
            updateStatement.setInt(2, postID);
            updateStatement.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateStatement);
            DBUtil.close(conn);
        }
    }
}
