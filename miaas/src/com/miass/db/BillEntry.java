/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.miass.db;

import java.sql.Date;

/**
 *
 * @author jasleen
 */
public class BillEntry {
    String name;
    String start,end;
    double cost;

    public BillEntry(long start, long end, String name, double cost) {
        this.start =new Date(start).toString();
        this.end = new Date(end).toString();
        this.name = name;
        this.cost = cost;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }
    
    
}
