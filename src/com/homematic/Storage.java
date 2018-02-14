package com.homematic;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Storage {

    private int id;
    private  String description;
    private int household_id;
    private int storage_type_id;

    public Storage(int id) throws SQLException {
        this.id = id;

        ResultSet rs = Database.GetDataFromDB("SELECT * FROM storage WHERE id = " + this.id);
        ResultSetMetaData rsmd = rs.getMetaData();
        int column_count = rsmd.getColumnCount();

        if (rs.next()) {
            this.description = rs.getString(2);
            this.household_id = rs.getInt(3);
            this.storage_type_id = rs.getInt(4);
        }

        Database.CloseConnection();
    }

    public Storage(String description, int household_id, int storage_type_id) {
        this.description = description;
        this.household_id = household_id;
        this.storage_type_id = storage_type_id;
        this.id =SaveStorageInDB(description, household_id, storage_type_id);
    }

    private int SaveStorageInDB(String description, int household_id, int storage_type_id) {
        return Database.WriteDataToDB("INSERT INTO storage (description, household_id, storage_type_id) " +
                "VALUES ('" + description + "', '" + household_id + "" +
                "', '" + storage_type_id + "')");
    }
}
