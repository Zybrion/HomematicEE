package homematic;

import java.sql.ResultSet;

public class Homematic {
    public static void main(String[] args){

        Adress adr = new Adress("England","N20","London","Londonstreet","213");

        System.out.println(adr.getId());
    }
}
