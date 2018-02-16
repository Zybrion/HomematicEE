package com.homematic;

public class Preference {
    private int product_type_id;
    private char preference_type;

    public Preference(int product_type_id, char preference_type) {
        this.product_type_id = product_type_id;
        this.preference_type = preference_type;
    }
}
