package com.homematic;

import java.sql.SQLException;

public class Homematic {
    public static void main(String[] args) throws SQLException {


        Registration.CreateDataset("Deutschland", "74182",
                "Obersulm", "Elisabethenstraße", "15",
                "Volksbank", "DE123456789123456789",
                1, "Test123",
                "Selimovic", "Nikola", "nikola@homematic.online", "admin",
                19950518, "");

        Adress adr = new Adress(1);
        System.out.println(adr.getCity());

    }
}
