package com.homematic;


import org.apache.commons.net.ftp.FTPClient;

class FTP{
    static String hostname;
    static int port;

    public static boolean uploadFile()
    {
        FTPClient client = new FTPClient();
        client.connect(hostname, port);
        return false;
    }
}