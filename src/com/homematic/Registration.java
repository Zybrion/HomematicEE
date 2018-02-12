package homematic;

import java.util.Date;

public class Registration {

    private static String household_name;

    private String adress_country;
    private String adress_postal_code;
    private String adress_city;
    private String adress_street;
    private String adress_number;

    private String payment_method_description;
    private String payment_method_iban;
    private boolean payment_method_sepa_ddm;

    private String user_name;
    private String user_firstname;
    private String user_email;
    private String user_password;
    private Date user_birthday;
    private int user_household_id;
    private String user_picture_path;

    public static void CreateDataset(String adress_country, String adress_postal_code,
                                     String adress_city, String adress_street, String adress_number,
                                     String payment_method_description, String payment_method_iban,
                                     boolean payment_method_sepa_ddm, String household_name,
                                     String user_name, String user_firstname, String user_email, String user_password,
                                     Date user_birthday, int user_household_id, String user_picture_path) {

        Adress adr = CreateAdressInDB(adress_country, adress_postal_code, adress_city,
                adress_street, adress_number);
        PaymentMethod pm = CreatePaymentMethodInDB(payment_method_description, payment_method_iban, payment_method_sepa_ddm);
        Household hd = CreateHouseholdInDB(household_name, adr.getId(), pm.getId());
        User user = CreateUserInDB(user_name, user_firstname, user_email, user_password, user_birthday,
                user_household_id, user_picture_path);
    }

    private static Household CreateHouseholdInDB(String household_name, int adress_id, int payment_method_id) {
        return new Household(household_name, adress_id, payment_method_id);
    }

    private static User CreateUserInDB(String name, String firstname, String email, String password, Date birthday,
                                      int household_id, String picture_path) {
        return new User(name, firstname, email, password, birthday, household_id, picture_path);
    }

    private static Adress CreateAdressInDB(String country, String postal_code, String city, String street, String number) {
        return new Adress(country, postal_code, city, street, number);
    }

    private static PaymentMethod CreatePaymentMethodInDB(String description, String iban, boolean sepa_ddm) {
        return new PaymentMethod(description, iban, sepa_ddm);
    }
}
