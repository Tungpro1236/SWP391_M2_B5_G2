package vn.edu.fpt.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-LAU3GQ90\\MSSQLSERVER01:1433;databaseName=Onlinelearning";
    private static final String USER = "sa";
    private static final String PASS = "43413112221a";
    
    protected Connection connection;

    public DBContext() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.connection = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Database connection failed", ex);
            throw new RuntimeException("Failed to initialize database connection", ex);
        }
    }

    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(DB_URL, USER, PASS);
            }
            return connection;
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Failed to get database connection", ex);
            throw new RuntimeException("Failed to get database connection", ex);
        }
    }

    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Failed to close database connection", ex);
            }
        }
    }

    public static void main(String[] args) {
        DBContext dbContext = null;
        try {
            dbContext = new DBContext();
            Connection con = dbContext.getConnection();
            
            if (con != null && !con.isClosed()) {
                System.out.println("Successfully connected to the database!");
                
                // Test query
                String testQuery = "SELECT COUNT(*) AS blog_count FROM blogs";
                try (var stmt = con.createStatement();
                     var rs = stmt.executeQuery(testQuery)) {
                    if (rs.next()) {
                        System.out.println("Total blogs in database: " + rs.getInt("blog_count"));
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (dbContext != null) {
                dbContext.closeConnection();
                System.out.println("Database connection closed.");
            }
        }
    }
}