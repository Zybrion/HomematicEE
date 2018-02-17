package com.homematic;

import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class Homematic {
    public static void main(String[] args) throws SQLException {

        Stock stock = new Stock(1);
        List<StockContent> stock_content = stock.GetStockContent();
        for (int i = 0; i < stock_content.size(); i++) {
            System.out.println(stock_content.get(i).toString());
        }

    }
}
