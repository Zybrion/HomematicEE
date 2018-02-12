package homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Adress {

    private int id;
    private String country;
    private String postal_code;
    private String city;
    private String street;
    private String number;

    public Adress(int id) throws SQLException {
        this.id = id;

        ResultSet rs = Database.GetDataFromDB("SELECT * FROM adress WHERE id = " + this.id);
        ResultSetMetaData rsmd = rs.getMetaData();
        int column_count = rsmd.getColumnCount();

        this.country = rs.getString(2);
        this.postal_code = rs.getString(3);
        this.city = rs.getString(4);
        this.street = rs.getString(5);
        this.number = rs.getString(6);

        Database.CloseConnection();
    }

    public Adress(String country, String postal_code, String city, String street, String number) {

        this.country = country;
        this.postal_code = postal_code;
        this.city = city;
        this.street = street;
        this.number = number;
        this.id = SaveAdressInDB(country, postal_code, city, street, number);

    }

    private int SaveAdressInDB(String country, String postal_code, String city, String street, String number) {
        return Database.WriteDataToDB("INSERT INTO adress (country, postal_code, city, street, number) " +
                "VALUES ('" + country + "', '" + postal_code + "" +
                "', '" + city + "', '" + street + "', '" + number + "')");
    }

    public int getId() {
        return id;
    }

    public String getCountry() {
        return country;
    }

    public String getPostal_code() {
        return postal_code;
    }

    public String getCity() {
        return city;
    }

    public String getStreet() {
        return street;
    }

    public String getNumber() {
        return number;
    }
}
