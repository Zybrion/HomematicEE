package com.homematic;

import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Date;

public class Meal {
    private int id;
    private Recipe[] recipe = new Recipe[20];
    private Date date;
    private int daytime_id;
    private boolean modified = false;
    private int household_id;

    public Meal(int id) throws SQLException {
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM meal WHERE id = " + id);
        this.id = id;
        this.recipe = GetRecipes(this.id);
        this.date = rs.getDate(3);
        this.daytime_id = rs.getInt(4);
        this.modified = rs.getBoolean(5);
        this.household_id = rs.getInt(6);
    }

    public Meal(Recipe[] recipe, Date date, int daytime_id, boolean modified, int household_id) {
        this.recipe = recipe;
        this.date = date;
        this.daytime_id = daytime_id;
        this.modified = modified;
        this.household_id = household_id;
        this.id = SaveMealInDB(recipe, date, daytime_id, modified, household_id);
    }

    private Recipe[] GetRecipes(int id) throws SQLException {
        Recipe[] recipes = null;

        ResultSetMetaData rsmd = null;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM meal WHERE id = " + id);
        if (rs.next()) {
            rsmd = rs.getMetaData();
            recipes = new Recipe[20];
            for (int i = 0; i < rsmd.getColumnCount(); i++) {
                recipes[i] = new Recipe(rs.getInt(2));
            }
        }

        return recipes;
    }

    private int SaveMealInDB(Recipe[] recipe, Date date, int daytime_id, boolean modified, int household_id) {
        int id = 0;
        for (int i = 0; i < recipe.length; i++) {
            id = Database.WriteDataToDB("INSERT INTO meal (recipe_id, date, daytime_id, modified, household_id) " +
                    "VALUES ('" + recipe[i].getId() + "', '" + date + "" +
                    "', '" + daytime_id + "', '" + modified + "', '" + household_id + "')");
        }

        return id;
    }
}
