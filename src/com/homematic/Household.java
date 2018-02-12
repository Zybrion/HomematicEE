package homematic;

public class Household {

    private int id;
    private String name;
    private int adress_id;
    private int payment_method_id;

    public Household(int id) {
        this.id = id;
    }

    public Household(String name, int adress_id, int payment_method_id) {
        this.name = name;
        this.adress_id = adress_id;
        this.payment_method_id = payment_method_id;
        this.id = SaveHouseholdInDB(name, adress_id, payment_method_id);
    }

    private int SaveHouseholdInDB(String name, int adress_id, int payment_method_id) {
        return Database.WriteDataToDB("INSERT INTO household (name, adress_id, payment_method_id) " +
                "VALUES ('" + name + "', '" + adress_id + "" +
                "', '" + payment_method_id + "')");
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getAdress_id() {
        return adress_id;
    }

    public int getPayment_method_id() {
        return payment_method_id;
    }
}
