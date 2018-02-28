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
import java.util.LinkedList;
import java.util.List;

public class MealPlan {

    private int household_id;
    private Meal[] meals = null;

    public MealPlan(int household_id, String from_date, String to_date) throws SQLException, ParseException {
        Meal[] meals = GetMeals(from_date, to_date);
        this.household_id = household_id;
        if (meals == null) {
            this.meals = null;
        } else {
            this.meals = meals;
        }
    }

    public MealPlan(int household_id, Meal[] meals) {
        this.household_id = household_id;
        this.meals = meals;
    }

    private Meal[] GetMeals(String from_date, String to_date) throws SQLException, ParseException {

        String s = "SELECT * FROM meal WHERE date >= '" + from_date
                + "' AND date <= '" + to_date + "' AND household_id = " + this.household_id +
                " AND (daytime_id = '101' OR daytime_id = '102' OR daytime_id = '103')";

        ResultSet rs = Database.GetDataFromDB(s);
        rs.last();
        int size = rs.getRow();
        rs.beforeFirst();
        Meal[] meals = new Meal[size];
        if (rs.next()) {
            for (int i = 0; i < size; i++) {
                Meal meal = new Meal(rs.getInt(1));
                meals[i] = meal;
            }
        }
        return meals;
    }

    public boolean SetMeals() throws SQLException {

        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String s = "";
        Calendar c = Calendar.getInstance();

        List<User> household_members = new LinkedList<>();
        household_members = MenuSuggestion.GetHouseholdMembers(this.household_id);
        String members = "";
        for (int i = 0; i < household_members.size(); i++) {
            if (!members.equals("")) {
                members = members + ";";
            }
            members = members + household_members.get(i).getId();
        }
        for (int i = 0; i < this.meals.length; i++) {
            if (this.meals[i] != null) {
                c.setTime(this.meals[i].getDate());
                s = sdf.format(c.getTime());
                Database.WriteDataToDB("INSERT INTO meal (recipe_id, date, daytime_id, household_id, members)" +
                        " VALUES ('" + this.meals[i].getRecipe()[0].getId() + "', '" + s +
                        "', '" + this.meals[i].getDaytime_id() + "', '" + this.meals[i].getHousehold_id() + "', '"
                        + members + "')");
            }

            //  VALUES ('3', '2018-03-01', '102', '0', '1', '1;2');
        }
        return true;
    }

    public Meal[] getMeals(String from_date, String to_date) throws SQLException, ParseException {
        return GetMeals(from_date, to_date);
    }
}
