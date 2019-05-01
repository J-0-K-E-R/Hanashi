/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import static dao.ReportedThreadsDAO.getNextReportID;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utilities.DBUtil;

/**
 *
 * @author robogod
 */
public class ClosedThreadsDAO {
    private static PreparedStatement insertStatement, fetchStatement, updateStatement;
    
    public static void close(pojos.ClosedThread cthread) {
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

            //Create the preparedstatement(s)
            insertStatement = conn.prepareStatement("insert into closed_threads values(?,?,?,null)");
            insertStatement.setInt(1, cthread.getThreadID());
            insertStatement.setString(2, cthread.getClosedBy());
            insertStatement.setString(3, cthread.getComment());
            insertStatement.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(insertStatement);
            DBUtil.close(conn);
        }
    }
    
    public static void open(int threadID) {
        Connection conn = null;
        
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

            //Create the preparedstatement(s)
            updateStatement = conn.prepareStatement("delete from closed_threads where Thread_ID = ?");
            updateStatement.setInt(1, threadID);
            updateStatement.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(updateStatement);
            DBUtil.close(conn);
        }
    }
    
    public static boolean isClosed(int threadID) {
        Connection conn = null;
        boolean isClosed = false;
        try {
            //Set up connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/hanashi", "root", "");

            //Create the preparedstatement(s)
            fetchStatement = conn.prepareStatement("select * from closed_threads where Thread_ID = ?;");
            fetchStatement.setInt(1, threadID);
            ResultSet rs = fetchStatement.executeQuery();
            
            if(rs.next()) {
                isClosed = true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            DBUtil.close(fetchStatement);
            DBUtil.close(conn);
        }
        
        return isClosed;
    }
    
}
