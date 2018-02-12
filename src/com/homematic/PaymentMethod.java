package com.homematic;

public class PaymentMethod {

    private int id;
    private String description;
    private String iban;
    private int sepa_ddm;

    public PaymentMethod(int id) {
        this.id = id;
    }

    public PaymentMethod(String description, String iban, int sepa_ddm) {
        this.description = description;
        this.iban = iban;
        this.sepa_ddm = sepa_ddm;
        this.id = SavePaymentMethodInDB(description, iban, sepa_ddm);
    }

    private int SavePaymentMethodInDB(String description, String iban, int sepa_ddm) {
        return Database.WriteDataToDB("INSERT INTO payment_method (description, iban, sepa_ddm) " +
                "VALUES ('" + description + "', '" + iban + "" +
                "', '" + sepa_ddm + "')");
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public String getIban() {
        return iban;
    }

    public int isSepa_ddm() {
        return sepa_ddm;
    }
}
