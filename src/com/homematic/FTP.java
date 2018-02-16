/*
package com.homematic;


import org.apache.commons.net.ftp.FTPClient;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import java.awt.*;
import java.io.IOException;
import java.io.InputStream;

class FTP{
    static String hostname = "192.168.178.5";
    static int port =21;
    static String username = "rene";
    static String password = "nikola1!";

    static FTPClient createClient(String hostname, int port, String username, String password)
    {
        FTPClient client = new FTPClient();
        try {
            client.connect(hostname, port);
            client.login(username, password);
            return client;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    static boolean deleteClient(FTPClient client)
    {
        try {
            client.logout();
            client.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static boolean uploadFile(Image image, int id)
    {
        FTPClient client = (hostname, port, username, password);
        try {
           InputStream inputStream =
        } catch (IOException e) {
            e.printStackTrace();
        }
        client.changeWorkingDirectory("profilePictures");
        client.storeFile()

        return false;
    }
}*/
