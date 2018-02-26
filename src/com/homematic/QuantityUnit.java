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

    public static double getSmallestUnit(double amount, int qu_id){
        switch(qu_id){
            case 1:
                return amount;
            case 2:
                return amount / 1000;
            case 3:
                return amount / 500;
            case 4:
                return amount;
            case 5:
                return amount / 1000;
            case 6:
                return amount;
            case 7:
                return amount;
            case 8:
                return amount;
            case 9:
                return amount;
            case 10:
                return amount;
            case 11:
                return amount;
            case 12:
                return amount;
            case 13:
                return amount;
            default:
                return amount;
        }
    }
}
