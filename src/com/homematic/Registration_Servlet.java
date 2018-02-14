package com.homematic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet(name = "Registration_Servlet")
public class Registration_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int sepa = 0;
        String sepa_ddm = request.getParameter("registration_sepa_ddm");
        if (sepa_ddm != null) {
            sepa = 1;
        }
        String s = request.getParameter("registration_birthdate");
        /*SimpleDateFormat date_format = new SimpleDateFormat("yyyy-mm-dd");
        Date birthday = null;
        try {
            birthday = date_format.parse(request.getParameter("registration_birthdate"));
        } catch (ParseException e) {
            e.printStackTrace();
        }*/
        Registration.CreateDataset(request.getParameter("registration_country"),
                request.getParameter("registration_postal_code"),
                request.getParameter("registration_city"),
                request.getParameter("registration_street"),
                request.getParameter("registration_number"),
                request.getParameter("registration_payment_method_description"),
                request.getParameter("registration_iban"),
                sepa,
                request.getParameter("registration_household_name"),
                request.getParameter("registration_name"),
                request.getParameter("registration_firstname"),
                request.getParameter("registration_email"),
                request.getParameter("registration_password"),
                s,
                request.getParameter("registration_picture_path"));

        try {
            boolean login = Login.LoginUser(request.getParameter("registration_email"),
                    request.getParameter("registration_password"), false, request, response);
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
