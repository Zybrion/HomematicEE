package com.homematic;

import java.security.MessageDigest;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login {

    private String email;
    private String password;
    private boolean no_logout;

    public static boolean LoginUser(String email, String password, boolean no_logout) throws SQLException {

        ResultSet rs = Database.GetDataFromDB("SELECT * FROm user WHERE email = " + email.toLowerCase());
        if (!rs.next()) {
            return false;
            //System.out.println("Kein Account zu dieser E-Mail-Adresse verfügbar");
        } else {
            email = email.toLowerCase();
            String hash = Registration.CreateHash(password);
            if (rs.next()) {
                if (!hash.equals(rs.getString(7))) {
                    return false;
                    //System.out.println("Passwort ist nicht korrekt");
                } else {
                    SetCookies();
                    StartSession();
                    return true;
                }
            } else {
                return false;
            }
        }
    }

    private static void SetCookies() {

    }

    private static void StartSession() {

    }

}
