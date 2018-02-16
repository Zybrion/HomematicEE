package com.homematic;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductType {

    private int id;
    private String description;
    private String category;

    public ProductType(int id) throws SQLException {
        this.id = id;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM product_type WHERE id = " + this.id);
        if (rs.next()) {
            this.description = rs.getString(2);
            this.category = rs.getString(3);
        }
        Database.CloseConnection();
    }
}
