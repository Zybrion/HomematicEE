package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class Recipe {

    private int id;
    private ProductType[] product_type;
    private int household_id;
    private RecipeDescription recipe_description;
    private double[] amount;
    private String description;
    private QuantityUnit[] quantity_unit;
    private Daytime[] daytimes;

    public Recipe(int id) throws SQLException {
        double[] amount = null;
        ProductType[] product_type = null;
        QuantityUnit[] quantity_unit = null;
        Daytime[] daytime = null;

        this.id = id;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM recipe WHERE id = " + this.id);
        ResultSetMetaData rsmd = rs.getMetaData();
        if (rs.next()) {
            this.description = rs.getString(6);
            this.household_id = rs.getInt(3);
            this.recipe_description = new RecipeDescription(rs.getInt(4));
            this.description = rs.getString(3);
            for (int i = 0; i < rsmd.getColumnCount(); i++) {
                amount[i] = rs.getDouble(5);
                product_type[i] = new ProductType(rs.getInt(2));
                quantity_unit[i] = new QuantityUnit(rs.getInt(7));
                daytime[i] = new Daytime(rs.getString(8));
            }
            this.amount = amount;
            this.product_type = product_type;
            this.quantity_unit = quantity_unit;
            this.daytimes = daytime;
        }
        //Database.CloseConnection();
    }

    public Recipe(ProductType[] product_type, int household_id, RecipeDescription recipe_description,
                  double[] amount, String description, QuantityUnit[] quantity_unit, Daytime[] daytime) {
        this.product_type = product_type;
        this.household_id = household_id;
        this.recipe_description = recipe_description;
        this.amount = amount;
        this.description = description;
        this.quantity_unit = quantity_unit;
        this.daytimes = daytime;
    }

    public static List<Recipe> GetAllRecipes(int household_id) throws SQLException {
        List<Recipe> recipes = new LinkedList<>();
        ResultSet rs = Database.GetDataFromDB("SELECT id FROM recipe WHERE household_id = " + household_id
        + "OR household_id is null");
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next()) {
                recipes.add(new Recipe(rs.getInt(1)));
        }
        Database.CloseConnection();
        return recipes;
    }

    public int getId() {
        return id;
    }

    public ProductType[] getProduct_type() {
        return product_type;
    }

    public double[] getAmount() {
        return amount;
    }

    public QuantityUnit[] getQuantity_unit() {
        return quantity_unit;
    }

    public Daytime[] getDaytimes() {
        return daytimes;
    }
}