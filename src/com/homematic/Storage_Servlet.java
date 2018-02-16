package com.homematic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "Storage_Servlet")
public class Storage_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mode = "";
        String create = request.getParameter("storage_create");
        String change = request.getParameter("storage_change");
        String delete = request.getParameter("storage_delete");
        if (create != null) {
            mode = "create";
        } else if (change != null) {
            mode = "change";
        } else if (delete != null) {
            mode = "delete";
        }

        HttpSession session = request.getSession(false);
        String household_id = "";
        String user_id = "";
        if (session != null) {
            household_id = (String) session.getAttribute("household_id");
        } else {

        }

        switch (mode) {
            case "create":
                Storage storage = new Storage(request.getParameter("storage_name"), Integer.parseInt(household_id),
                        Integer.parseInt(request.getParameter("storage_type")));
                break;
            case "change":
                Database.UpdateDataInDB("UPDATE storage SET description = '"+request.getParameter("storage_name")+"',"
                        +"storage_type_id = '"+Integer.parseInt(request.getParameter("storage_type"))
                        +"' WHERE id = " + Integer.parseInt(request.getParameter("hid_name")));
                break;
            case "delete":
                Database.DeleteDataFromDB("DELETE FROM storage where id = " +
                        Integer.parseInt(request.getParameter("hid_name")));
                break;
            default:
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
