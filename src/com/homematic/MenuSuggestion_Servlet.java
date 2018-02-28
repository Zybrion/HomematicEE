package com.homematic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import  java.lang.*;

@WebServlet(name = "MenuSuggestion_Servlet")
public class MenuSuggestion_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int household_id = Integer.parseInt((String)session.getAttribute("household_id"));

        String from_date = request.getParameter("from_date");
        String to_date = request.getParameter("to_date");

        try {
            MealPlan mp = MenuSuggestion.CreateNewMenuSuggestion(household_id, from_date, to_date);
            boolean meals_set = mp.SetMeals();

            Cookie c = new Cookie("menuCreated", "me");
            c.setMaxAge(-1);
            c.setPath(request.getContextPath());
            response.addCookie(c);

            response.sendRedirect("../show/meal_plan.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
