/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.miass.db;

import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jasleen
 */
public class DBOperations {

    private static Connection connect = null;

    public static Connection getConnection() {
        try {
            // this will load the MySQL driver, each DB has its own driver
            Class.forName("com.mysql.jdbc.Driver");
            // setup the connection with the DB.
            connect = DriverManager
                    .getConnection("jdbc:mysql://localhost/miaas?"
                            + "user=root&password=");
        } catch (Exception e) {
            System.out.println(e);
        }
        return connect;
    }

    public static String login(String username, String password) {
        String id = null;
        if (connect == null) {
            connect = getConnection();
        }
        try {
            ResultSet rs = connect.createStatement().executeQuery("select id from login where username="
                    + "'" + username + "' and password='" + password + "'");
            if (rs.next()) {
                id = rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return id;
    }

    public static int createEmulator(String id, String name, String port, String version) {
        if (connect == null) {
            connect = getConnection();
        }
        try {
            int res= connect.createStatement().executeUpdate("INSERT INTO   emulator  ( idowner ,  name ,  port ,  version  ) VALUES ('" + id + "', '" + name + "', '" + port + "', '" + version + "')");
            URL url=new URL("http://54.183.24.79:8080/MyTacks/emulator/create?emulName="+name+"&portNo="+port+"&targetId="+version);
            HttpURLConnection connection=(HttpURLConnection)url.openConnection();
            //System.out.println("http://54.183.24.79:8080/MyTacks/emulator/create?emulName="+name+"&portNo="+port+"&targetId="+version);
            connection.setRequestMethod("GET");
            connection.connect();
            System.out.println(connection.getResponseCode());
            return res;
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;

    }

    public static ArrayList<Emulator> getEmulators(String id) {
        ArrayList<Emulator> em = new ArrayList<>();
        if (connect == null) {
            connect = getConnection();
        }
        try {
            ResultSet rs = connect.createStatement().executeQuery("SELECT * FROM emulator where idowner=" + id);
            while(rs.next())
            {
                em.add(new Emulator(rs.getString(1), rs.getString(3), rs.getString(4), rs.getString(5), (rs.getInt(6) != 0)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return em;
    }

    public static void launchEmulator(String id)
    {
        if (connect == null) {
            connect = getConnection();
        }
        try
        {
            String name=null,port=null;
            ResultSet rs=connect.createStatement().executeQuery("SELECT name,port FROM emulator where idemulator='"+id+"'");
            if(rs.next())
            { name=rs.getString(1);
            port=rs.getString(2);
            }
            if(name!=null)
            {
                URL url=new URL("http://54.183.24.79:8080/MyTacks/emulator/launch?emulName="+name+"&portNo="+port);
            HttpURLConnection connection=(HttpURLConnection)url.openConnection();
            System.out.println("http://54.183.24.79:8080/MyTacks/emulator/launch?emulName="+name+"&port="+port);
            connection.setRequestMethod("GET");
            connection.connect();
            System.out.println(connection.getResponseCode());
            connect.createStatement().executeUpdate("UPDATE `emulator` SET `state`='1' WHERE `idemulator`='"+id+"'");
            connect.createStatement().executeUpdate("INSERT INTO  billing  (   emulatorid ,  starttime ) VALUES ('"+id+"', '"+System.currentTimeMillis()+"'); ");
            }
        }
        catch(Exception e)
        {
        }
    }
     public static void stopEmulator(String id)
    {
        if (connect == null) {
            connect = getConnection();
        }
        try
        {
             String name=null,port=null;
            ResultSet rs=connect.createStatement().executeQuery("SELECT name,port FROM emulator where idemulator='"+id+"'");
            if(rs.next())
            { name=rs.getString(1);
            port=rs.getString(2);
            }
            if(name!=null)
            {
                URL url=new URL("http://54.183.24.79:8080/MyTacks/emulator/Stop?portNo="+port);
            HttpURLConnection connection=(HttpURLConnection)url.openConnection();
            //System.out.println("http://54.183.24.79:8080/MyTacks/emulator/launch
            connection.connect();
            System.out.println(connection.getResponseCode());
            Long starttime=null,endtime=System.currentTimeMillis();
            Integer billid=null;
            connect.createStatement().executeUpdate("UPDATE `emulator` SET `state`='0' WHERE `idemulator`='"+id+"'");
             rs=connect.createStatement().executeQuery("SELECT idbilling,starttime FROM miaas.billing where emulatorid='"+id+"' order by idbilling desc limit 1");
            if(rs.next())
            {
            billid=rs.getInt(1);
            starttime=rs.getLong(2);
            }
            if(billid==null||starttime==null)
                return;
             long seconds=TimeUnit.MILLISECONDS.toSeconds(endtime-starttime);
            double cost=seconds*0.001;
            connect.createStatement().executeUpdate("UPDATE  billing  SET   endtime  = '"+endtime+"',  cost  = '"+cost+"' WHERE  idbilling  = '"+billid+"'");
       }}
        catch(Exception e)
        {
            System.out.println(e);
        }
    }
     public static void deleteEmulator(String id)
     {
      if (connect == null) {
            connect = getConnection();
        }
        try {
            connect.createStatement().executeUpdate("DELETE FROM `billing`" +"WHERE emulatorid="+id);
            connect.createStatement().executeUpdate("DELETE FROM `miaas`.`emulator`" +"WHERE idemulator="+id);
        } catch (SQLException ex) {
            Logger.getLogger(DBOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
     }
     public static ArrayList<BillEntry> getBills(String id)
     {
         if (connect == null) {
            connect = getConnection();
        }
         ArrayList<BillEntry> bills=new ArrayList<>();
        try {
            ResultSet rs=connect.createStatement().executeQuery("SELECT emulator.name,starttime,endtime,cost FROM miaas.billing,emulator where billing.emulatorid= emulator.idemulator and emulator.idowner="+id);
            while(rs.next())
            {
            bills.add(new BillEntry(rs.getLong(2), rs.getLong(3), rs.getString(1), rs.getDouble(4)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bills;
     }
    public static void main(String args[]) {
       System.out.println(login("admin", "admin"));
    }
}
