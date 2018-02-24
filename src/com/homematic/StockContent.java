package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

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

    public static double GetStockAmount(int product_type_id, List<StockContent> stock_content) {
        double amount = 0;
        for (int i = 0; i < stock_content.size(); i++) {
            if (stock_content.get(i).getProduct().getProduct_type().getId() == product_type_id) {
                amount = stock_content.get(i).getAmount();
            }
        }
        return amount;
    }

    public int getStorage_id() {
        return storage_id;
    }

    public Product getProduct() {
        return product;
    }

    public double getAmount() {
        return amount;
    }

    public Date getBbd() {
        return bbd;
    }

    public int getStock_id() {
        return stock_id;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
