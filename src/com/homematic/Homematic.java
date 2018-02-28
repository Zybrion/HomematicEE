package com.homematic;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.List;

public class Homematic {
    public static void main(String[] args) throws SQLException, ParseException {

        /*Stock stock = new Stock(1);
        List<StockContent> stock_content = stock.GetStockContent();
        for (int i = 0; i < stock_content.size(); i++) {
            System.out.println(stock_content.get(i).toString());
        }
        Recipe recipe = new Recipe(1);

        java.util.Date datum;
        java.util.Date datum2;
        String date = "2018-03-13";
        String date2 = "2018-03-04";

        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        datum = sdf.parse(date);
        datum2 = sdf.parse(date2);

        Calendar c = Calendar.getInstance();
        Calendar c2 = Calendar.getInstance();

        System.out.println(ChronoUnit.DAYS.between(datum.toInstant(), datum2.toInstant()));*/

        MealPlan mp = MenuSuggestion.CreateNewMenuSuggestion(1, "2018-02-28", "2018-03-06");
        boolean meals_set = mp.SetMeals();

        System.out.println("Test");


    }
}
