package com.homematic;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login {

    private String email;
    private String password;
    private boolean no_logout;

    public static boolean LoginUser(String email, String password, boolean no_logout,
                                    HttpServletRequest request, HttpServletResponse response) throws SQLException {

        ResultSet rs = Database.GetDataFromDB("SELECT * FROM user WHERE email = '" + email.toLowerCase() + "'");
        if (!rs.next()) {
            return false;
            //System.out.println("Kein Account zu dieser E-Mail-Adresse verfügbar");
        } else {
            email = email.toLowerCase();
            String hash = Registration.CreateHash(password);
            if (!hash.equals(rs.getString(7))) {
                return false;
                //System.out.println("Passwort ist nicht korrekt");
            } else {
                SetCookiesLogin(request, response, "user_id", Integer.toString(rs.getInt(1)), no_logout);
                StartSession(request, response);
                return true;
            }
        }
    }

    public static void SetCookiesLogin(HttpServletRequest request, HttpServletResponse response,
                                       String name, String value, boolean no_logout) {
            Cookie cookie = new Cookie(name, value);
            //cookie.setDomain("com.homematic.online");
            cookie.setPath("/");
        if (no_logout) {
            cookie.setMaxAge(7*24*60*60); //One Week
        } else {
            cookie.setMaxAge(-1); //Until Browser is closed
        }
        response.addCookie(cookie);

        //http://tutorials.jenkov.com/java-servlets/cookies.html

    }

    private static void StartSession(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
    }

    //https://www.journaldev.com/1907/java-session-management-servlet-httpsession-url-rewriting
    //https://stackoverflow.com/questions/9203857/want-to-create-a-filter-to-check-for-a-cookie-then-save-object-and-reference-fr

}
