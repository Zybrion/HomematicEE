package com.homematic;

import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

public class MenuSuggestion {

    private static String from_date;
    private static String to_date;

    public static MealPlan CreateNewMenuSuggestion(int household_id, String from_date, String to_date) throws SQLException, ParseException {
        MealPlan mp = null; //new MealPlan(household_id, from_date, to_date);
        List<StockContent> stock_content = new LinkedList<>();
        List<Recipe> all_recipes = new LinkedList<>();
        List<Recipe> recipes = new LinkedList<>();
        List<Preference> preferences = new LinkedList<>();
        List<Preference> pref = new LinkedList<>();
        List<User> household_members = new LinkedList<>();

        java.util.Date date;
        java.util.Date date2;
        java.util.Date datum;
        DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        datum = sdf.parse(from_date);
        date = sdf.parse(from_date);
        date2 = sdf.parse(to_date);
        Calendar c = Calendar.getInstance();
        Calendar c2 = Calendar.getInstance();
        Calendar cal = Calendar.getInstance();

        int date_difference = 0;
        int meal_counter = 0;

        Stock stock = new Stock(household_id);
        stock_content = stock.GetStockContent();
        recipes = Recipe.GetAllRecipes(household_id);

        for (int i = 0; i < recipes.size(); i++) {
            all_recipes.add(recipes.get(i));
        }

        household_members = GetHouseholdMembers(household_id);
        for (int i = 0; i < household_members.size(); i++) {
            pref = null;
            pref = household_members.get(i).GetUserPreferences();
            for (int y = 0; y < pref.size(); y++) {
                preferences.add(pref.get(y));
            }
        }

        Meal[] meals = mp.getMeals();
        Meal[] new_meals = new Meal[((int) ChronoUnit.DAYS.between(date.toInstant(), date2.toInstant())) * 3];
        date_difference = (int) ChronoUnit.DAYS.between(date.toInstant(), date2.toInstant());
        //Loopt über 7 Tage (eine Woche)
        for (int i = 0; i <= date_difference; i++) {
            boolean gen_101 = true;
            boolean gen_102 = true;
            boolean gen_103 = true;
            //Loopt über alle Mahlzeiten und vergleicht, ob das Datum der bereits bestehenden Mahlzeiten übereinstimmt mit
            //Neuen geplanten Mahlzeiten. Wenn nein, wird
            //25.02.2018 | Mittagessen am 25.02.3018
            for (int y = 0; y < meals.length; y++) {
                if (meals[y].getDate() == cal.getTime() && meals[y].getDaytime_id() == 101) {
                    gen_101 = false;
                }
                if (meals[y].getDate() == cal.getTime() && meals[y].getDaytime_id() == 102) {
                    gen_102 = false;
                }
                if (meals[y].getDate() == cal.getTime() && meals[y].getDaytime_id() == 103) {
                    gen_103 = false;
                }
            }
            if (gen_101) {
                new_meals[meal_counter] = CreateMeal(household_id, cal.getTime(), 101, recipes, stock_content);
                meal_counter++;
            }
            if (gen_102) {
                new_meals[meal_counter] = CreateMeal(household_id, cal.getTime(), 102, recipes, stock_content);
                meal_counter++;
            }
            if (gen_103) {
                new_meals[meal_counter] = CreateMeal(household_id, cal.getTime(), 103, recipes, stock_content);
                meal_counter++;
            }
            cal.setTime(datum);
            cal.add(Calendar.DATE, 1);
        }
        mp = new MealPlan(household_id, new_meals);
        return mp;
        // Sicherung in Datenbank muss noch erfolgen
    }

    private static Meal CreateMeal(int household_id, Date date, int daytime_id,
                                   List<Recipe> all_recipes, List<StockContent> stock_content) throws SQLException, ParseException {

        Meal meal = null;
        Recipe[] rec = null;

        List<StockContent> stock = new LinkedList<>();

        List<Recipe> recipes = new LinkedList<>();
        List<Recipe> recipes_help = new LinkedList<>();
        for (int i = 0; i < all_recipes.size(); i++) {
            Daytime[] daytime = all_recipes.get(i).getDaytimes();
            String[] day = daytime[0].getId().split(";");
            // Prüfen, ob Rezept zur Tageszeit passt
            for (int j = 0; j < day.length; j++) {
                if (Integer.parseInt(day[i]) == daytime_id) {
                    // Rezept ist relevant für Generierung
                    recipes.add(all_recipes.get(i));
                }
            }
        }
        for (int i = 0; i < recipes.size(); i++) {
            recipes_help.add(recipes.get(i));
        }

        // Zufällige Rezeptauswahl mit anschließendem Löschen des Rezepts aus dem Rezeptpool
        Random random = null;
        int min = 0;
        double amount_dummy = 0;
        double[] amount = null;
        for (int i = 0; i < recipes.size(); i++) {
            Recipe recipe = recipes.get(random.nextInt((recipes.size() - min) + 1) + min);
            amount = recipe.getAmount();
            int cnt = 0;
            //Jedes benötigte Produkt mit dem vorhanden Vorrat überprüfen
            while (cnt != -1) {
                for (int j = 0; j < recipe.getProduct_type().length; j++) {
                    for (int k = 0; k < stock_content.size(); k++) {
                        if (recipe.getProduct_type()[j].getId() == stock_content.get(k).getProduct().getProduct_type().getId()) {
                            amount_dummy = amount_dummy + stock_content.get(k).getAmount();
                        }
                    }
                    if (amount[j] <= amount_dummy) {
                        cnt++;
                        amount_dummy = 0;
                    } else {
                        cnt--;
                    }
                }
                // Alle benötigten Produkte sind im Vorrat verfügbar
                // Mahlzeit-Objekt erzeugen & die Vorräte reservieren und abbuchen (nicht auf DB!!)
                if (cnt >= recipe.getProduct_type().length) {
                    double amount_needed = 0;
                    for (int j = 0; j < recipe.getProduct_type().length; j++) {
                        amount_needed = recipe.getAmount()[j];
                        while (amount_needed != 0) {
                            for (int k = 0; k < stock_content.size(); k++) {
                                if (amount_needed == 0) {
                                    continue;
                                }
                                if (recipe.getProduct_type()[j].getId() == stock_content.get(k).getProduct().getProduct_type().getId()) {
                                    if (stock_content.get(k).getAmount() < amount_needed) {
                                        amount_needed = amount_needed - stock_content.get(k).getAmount();
                                        stock_content.get(k).setAmount(0);
                                    } else {
                                        stock_content.get(k).setAmount(stock_content.get(k).getAmount() - amount_needed);
                                        amount_needed = 0;
                                    }
                                }
                            }
                        }
                    }
                    rec[0] = recipe;
                    meal = new Meal(rec, date, daytime_id, false, household_id);
                }
            }
            recipes.remove(i);
        }
        // Es konnte noch keine Mahlzeit erzeugt werden, daher wird weiter nach einem Rezept gesucht
        if (meal == null) {
            recipes.clear();
            for (int i = 0; i < recipes_help.size(); i++) {
                recipes.add(recipes_help.get(i));
            }

            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date max_bbd = sdf.parse(to_date);
            Calendar c = Calendar.getInstance();
            c.setTime(max_bbd);
            c.add(Calendar.DATE, 14);
            int date_difference = 0;

            for (int j = 0; j < stock_content.size(); j++) {
                date_difference = (int) ChronoUnit.DAYS.between(stock_content.get(j).getBbd().toInstant(),
                        c.getTime().toInstant());
                if (date_difference > 0) {
                    stock.add(stock_content.get(j));
                }
            }
            for (int j = 0; j < stock.size(); j++) {
                for (int i = 0; i < recipes.size(); i++) {
                    Recipe recipe = recipes.get(random.nextInt((recipes.size() - min) + 1) + min);
                    amount = recipe.getAmount();
                    for (int z = 0; z < recipe.getProduct_type().length; z++) {
                        if (recipe.getProduct_type()[z].getId() == stock.get(j).getProduct().getProduct_type().getId()) {
                            stock.get(j).setAmount((stock.get(j).getAmount() - amount[z]));
                            if (stock.get(j).getAmount() < 0) {
                                stock.get(j).setAmount(0);
                            }
                            for (int k = 0; k < stock_content.size(); k++) {
                                if (stock_content.get(k).getProduct().getProduct_type().getId()
                                        == stock.get(j).getProduct().getProduct_type().getId()) {
                                    stock_content.get(k).setAmount(stock.get(k).getAmount());
                                }
                            }
                            rec[0] = recipe;
                            meal = new Meal(rec, date, daytime_id, false, household_id);
                        }
                    }
                }
            }
        }

        if (meal == null) {
            recipes.clear();
            for (int i = 0; i < recipes_help.size(); i++) {
                recipes.add(recipes_help.get(i));
            }

            for (int i = 0; i < recipes.size(); i++) {
                Recipe recipe = recipes.get(random.nextInt((recipes.size() - min) + 1) + min);
                rec[0] = recipe;
                meal = new Meal(rec, date, daytime_id, false, household_id);
            }

        }

        return meal;

    }

    private static List<User> GetHouseholdMembers(int household_id) throws SQLException {
        List<User> user = new LinkedList<>();
        ResultSet rs = Database.GetDataFromDB("SELECT id FROM user WHERE household_id = " + household_id);
        while (rs.next()) {
            user.add(new User(rs.getInt(1)));
        }
        Database.CloseConnection();
        return user;
    }

}
