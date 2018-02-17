package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class Stock {

    private int id;
    private int household_id;
    private List<StockContent> stock_content;

    public Stock(int household_id) throws SQLException {
        this.household_id = household_id;
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM stock WHERE household_id = "
                + this.household_id);
        if (rs.next()) {
            this.id = rs.getInt(1);
        }
    }

    public List<StockContent> GetStockContent() throws SQLException {
        List<StockContent> stock_content = new LinkedList<>();
        ResultSet rs = Database.GetDataFromDB("SELECT * FROM stock_content WHERE stock_id = " + this.id);
        ResultSetMetaData rsmd = rs.getMetaData();
        if (rs.next()) {
            for (int i = 0; i < rsmd.getColumnCount(); i++) {
                stock_content.add(new StockContent(rs.getInt(1), new Product(rs.getInt(2)),
                        rs.getDouble(3), rs.getDate(4), rs.getInt(5)));
            }
        }
        Database.CloseConnection();

        return stock_content;
    }
}
