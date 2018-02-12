package com.homematic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "Login_Servlet")
public class Login_Servlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean no_logout = Boolean.parseBoolean(request.getParameter("login_no_logout"));
        try {
            boolean login = Login.LoginUser(request.getParameter("login_email"),
                    request.getParameter("login_password"), no_logout, request, response);
            if (login) {
                response.sendRedirect("/index.html");
            } else {
                response.sendRedirect("login.html");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
