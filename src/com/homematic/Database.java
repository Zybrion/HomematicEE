package com.homematic;

import java.sql.*;
import java.sql.Connection;
import java.util.Properties;

public class Database {

    private static String hostname = "homematic-projekt.ddns.net";
    private static short port = 1207;
    private static String db_name = "homematic";
    private static String user = "homematiccon";
    private static String password = "J+eXyf#Q";
    private static String url = "";
    private static String no_ssl = "useSSL=false";

    private static Connection connection = GetConnection();

    private static Connection GetConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
            System.out.println("Unable to load driver");
            e.printStackTrace();
        }
        try {
            url = "jdbc:mysql://" + hostname + ":" + port + "/" + db_name + "?" + no_ssl;
            Properties properties = new Properties();
            properties.put("connectTimeout", "" + (15 * 60 * 60));
            String dbConnectionString = url + user + password;
            return DriverManager.getConnection(dbConnectionString, properties);


            //return DriverManager.getConnection(url, user, password);
        } catch (SQLException sqle) {
            System.out.println("SQLException: " + sqle.getMessage());
            System.out.println("SQLState: " + sqle.getSQLState());
            System.out.println("VendorError: " + sqle.getErrorCode());
            sqle.printStackTrace();
        }
        return null;
    }

    public static void CloseConnection() {
        /*try {
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }*/
    }

    public static void CloseConnection2() {
        try {
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static boolean CheckConnection() {
        boolean is_closed = false;
        try {
            is_closed = connection.isClosed();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return is_closed;
    }

    public static ResultSet GetDataFromDB(String statement) {

        if (connection == null) {
            connection = GetConnection();
        }
        Statement st = null;
        ResultSet rs = null;
        try {
            st = connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            rs = st.executeQuery(statement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static int WriteDataToDB(String statement) {

        if (connection == null) {
            connection = GetConnection();
        }
        Statement st = null;
        ResultSet rs = null;
        int id = 0;
        try {
            st = connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            id = st.executeUpdate(statement, Statement.RETURN_GENERATED_KEYS);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            rs = st.getGeneratedKeys();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        boolean bool = false;
        try {
            bool = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (bool) {
            try {
                id = rs.getInt(1);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return id;
    }

    public static boolean DeleteDataFromDB(String statement) {

        if (connection == null) {
            connection = GetConnection();
        }
        Statement st = null;
        ResultSet rs = null;
        try {
            st = connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        try {
            st.executeUpdate(statement);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean UpdateDataInDB(String statement) {

        if (connection == null) {
            connection = GetConnection();
        }
        Statement st = null;
        ResultSet rs = null;
        boolean updt = false;
        try {
            st = connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            st.executeUpdate(statement);
            updt = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updt;
    }


}
