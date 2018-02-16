package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class User {

    private int id;
    private String name;
    private String firstname;
    private String email;
    private String birthday;
    private int household_id;
    private Preference[] preference;
    private String picture_path;

    public User(int id) {
        this.id = id;
    }

    public User(String name, String firstname, String email, String password, String birthday,
                int household_id, String picture_path) {
        this.name = name;
        this.firstname = firstname;
        this.email = email;
        this.birthday = birthday;
        this.household_id = household_id;
        this.id = SaveUserInDB(name, firstname, email, password, birthday, household_id, picture_path);
    }

    private int SaveUserInDB(String name, String firstname, String email, String password, String birthday, int household_id, String picture_path) {
        int userrole_id = 1;
        String pw_hash = Registration.CreateHash(password);
        return Database.WriteDataToDB("INSERT INTO user (name, firstname, email, birthday, household_id, " +
                "password, userrole_id, picture_path) " +
                "VALUES ('" + name + "', '" + firstname + "" +
                "', '" + email.toLowerCase() + "', '" + birthday + "', '" + household_id + "', '"
                + pw_hash + "', '" + userrole_id + "', '" + picture_path + "')");
    }

    public Preference[] GetUserPreferences(int user_id) throws SQLException {
        Preference[] preferences = null;
        ResultSetMetaData rsmd = null;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM preferences WHERE user_id = " + user_id);
        if (rs.next()) {
            rsmd = rs.getMetaData();
            preferences = new Preference[rsmd.getColumnCount()];
            for (int i = 0; i <rsmd.getColumnCount(); i++){
                preferences[i] = new Preference(rs.getInt(1), rs.getString(2).charAt(0));
            }
        }
        return preferences;
    }

    public String getName() {
        return name;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getEmail() {
        return email;
    }

    public String getBirthday() {
        return birthday;
    }

    public int getHousehold_id() {
        return household_id;
    }

    public String getPicture_path(int id) throws SQLException {
        ResultSet rs = Database.GetDataFromDB("SELECT picture_path FROM user WHERE id = '" + id + "'");
        if (!rs.next()) {
            picture_path = rs.getString(1);
        }
        return picture_path;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public void setPicture_path(String picture_path) {
        this.picture_path = picture_path;
    }
}
