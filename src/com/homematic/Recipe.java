package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Recipe {

    private int id;
    private ProductType[] product_type;
    private int household_id;
    private RecipeDescription recipe_description;
    private double[] amount;
    private String description;
    private QuantityUnit[] quantity_unit;

    public Recipe(int id) throws SQLException {
        double[] amount = null;
        ProductType[] product_type = null;
        QuantityUnit[] quantity_unit = null;

        this.id = id;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM recipe WHERE id = " + this.id);
        ResultSetMetaData rsmd = rs.getMetaData();
        if (rs.next()) {
            this.description = rs.getString(6);
            this.household_id = rs.getInt(3);
            this.recipe_description = new RecipeDescription(rs.getInt(4));
            this.description = rs.getString(3);
            for (int i = 0; i < rsmd.getColumnCount(); i++){
                amount[i] = rs.getDouble(5);
                product_type[i] = new ProductType(rs.getInt(2));
                quantity_unit[i] = new QuantityUnit(rs.getInt(7));
            }
            this.amount = amount;
            this.product_type = product_type;
            this.quantity_unit = quantity_unit;

        }
        Database.CloseConnection();
    }

    public Recipe(ProductType[] product_type, int household_id, RecipeDescription recipe_description,
                  double[] amount, String description, QuantityUnit[] quantity_unit) {
        this.product_type = product_type;
        this.household_id = household_id;
        this.recipe_description = recipe_description;
        this.amount = amount;
        this.description = description;
        this.quantity_unit = quantity_unit;
    }

    public int getId() {
        return id;
    }
}