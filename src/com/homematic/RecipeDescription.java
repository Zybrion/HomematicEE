package com.homematic;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RecipeDescription {

    private int id;
    private String description;

    public RecipeDescription(int id) throws SQLException {
        this.id = id;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM recipe_description WHERE id = " + this.id);
        if (rs.next()) {
            this.description = rs.getString(2);
        }
        Database.CloseConnection();
    }
}
