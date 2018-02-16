package com.homematic;

import java.sql.ResultSet;
import java.sql.SQLException;

public class QuantityUnit {

    private int id;
    private String description;
    private String sign;

    public QuantityUnit(int id) throws SQLException {
        this.id = id;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM quantity_unit WHERE id = " + this.id);
        if (rs.next()) {
            this.description = rs.getString(2);
            this.sign = rs.getString(3);
        }
        Database.CloseConnection();
    }
}
