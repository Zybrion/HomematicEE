package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;

public class MealPlan {

    private int household_id;
    private Meal[] meals = null;

    public MealPlan(int household_id, String from_date, String to_date) throws SQLException, ParseException {
        this.household_id = household_id;
        this.meals = GetMeals(from_date, to_date);
    }

    public MealPlan(int household_id, Meal[] meals) {
        this.household_id = household_id;
        this.meals = meals;
    }

    private Meal[] GetMeals(String from_date, String to_date) throws SQLException, ParseException {

        ResultSet rs = Database.GetDataFromDB("SELECT * FROM meal WHERE date >= '" + from_date
                + "' AND date <= '" + to_date + "' AND household_id = " + this.household_id +
                " AND (daytime_id = '101' OR daytime_id = '102' OR daytime_id = '103')");
        rs.last();
        int size = rs.getRow();
        rs.beforeFirst();
        Meal[] meals = new Meal[size];
        ResultSetMetaData rsmd = rs.getMetaData();
        if (rs.next()) {
            for (int i = 0; i < rsmd.getColumnCount(); i++) {
                meals[i] = new Meal(rs.getInt(1));
            }
        }
        return meals;
    }

    public boolean SetMeals() {
        for (int i = 0; i < this.meals.length; i++) {

        }
        return true;
    }

    public Meal[] getMeals() {
        return meals;
    }
}
