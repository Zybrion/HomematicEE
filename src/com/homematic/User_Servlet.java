package com.homematic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "User_Servlet")
public class User_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mode = "";
        String create = request.getParameter("user_create");
        String change = request.getParameter("user_change");
        String delete = request.getParameter("user_delete");
        if (create != null) {
            mode = "create";
        } else if (change != null) {
            mode = "change";
        } else if (delete != null) {
            mode = "delete";
        }

        HttpSession session = request.getSession(false);
        String household_id = "";
        String user_id = "";
        if (session != null) {
            household_id = (String) session.getAttribute("household_id");
        } else {

        }
        switch (mode) {
            case "create":
                User user = new User(request.getParameter("user_name"),
                        request.getParameter("user_firstname"),
                        request.getParameter("user_email"),
                        request.getParameter("user_password"),
                        request.getParameter("user_birthday"),
                        Integer.parseInt(household_id),
                        request.getParameter("user_picture_path"));
                break;
            case "change":
                Database.UpdateDataInDB("UPDATE user SET name = '" + request.getParameter("user_name") + "',"
                        + "firstname = '" + request.getParameter("user_firstname") + "',"
                        + "email = '" + request.getParameter("user_email") + "',"
                        + "birthday = '" + request.getParameter("user_birthday") + "',"
                        + "password = '" + Registration.CreateHash(request.getParameter("user_password")) + "',"
                        + "picture_path = '" + request.getParameter("user_picture_path")
                        + "' WHERE id = " + Integer.parseInt((String) session.getAttribute("user_id")));
                break;
            case "delete":
                Database.DeleteDataFromDB("DELETE FROM user where id = " +
                        Integer.parseInt((String) session.getAttribute("user_id")));
                break;
            default:
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
