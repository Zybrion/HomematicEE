package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Product {

    private int id;
    private ProductType product_type;
    private String description;
    private String brand;
    private int amount;
    private QuantityUnit quantity_unit;
    private double price;
    private int currency_id;

    public Product(int id) throws SQLException {
        this.id = id;

        ResultSet rs = Database.GetDataFromDB("SELECT * FROM product WHERE id = " + this.id);
        if (rs.next()) {
            this.product_type = new ProductType(rs.getInt(2));
            this.description = rs.getString(3);
            this.brand = rs.getString(4);
            this.amount = rs.getInt(5);
            this.quantity_unit = new QuantityUnit(rs.getInt(6));
            this.price = rs.getDouble(7);
            this.currency_id = rs.getInt(8);
        }
        Database.CloseConnection();
    }

    public Product(ProductType product_type, String description, String brand, int amount,
                   QuantityUnit quantity_unit, double price, int currency_id) {
        this.product_type = product_type;
        this.description = description;
        this.brand = brand;
        this.amount = amount;
        this.quantity_unit = quantity_unit;
        this.price = price;
        this.currency_id = currency_id;
    }

    public String getDescription() {
        return description;
    }

    public String getBrand() {
        return brand;
    }

    public ProductType getProduct_type() {
        return product_type;
    }

    public int getAmount() {
        return amount;
    }
}
