package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Date;

public class MealPlan {

    private Meal[] meals = null;

    public MealPlan(Date from_date, Date to_date) throws SQLException {
        this.meals = GetMeals(from_date, to_date);
    }

    private Meal[] GetMeals(Date from_date, Date to_date) throws SQLException {
        Meal[] meals = new Meal[100];
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM meal WHERE date >= " + from_date
                + "' AND date <= " + to_date);
        ResultSetMetaData rsmd = rs.getMetaData();
        if (rs.next()) {
            for (int i = 0; i < rsmd.getColumnCount(); i++) {
                meals[i] = new Meal(rs.getInt(1));
            }
        }
        return meals;
    }
}
