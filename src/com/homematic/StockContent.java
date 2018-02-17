package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Date;

public class StockContent {

    private int storage_id;
    private Product product;
    private double amount;
    private Date bbd;
    private int stock_id;

    public StockContent(int storage_id, Product product, double amount, Date bbd, int stock_id) throws SQLException {
            this.storage_id = storage_id;
            this.product = product;
            this.amount = amount;
            this.bbd = bbd;
            this.stock_id = stock_id;
    }
}
