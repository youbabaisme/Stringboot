/**
 * Copyright 2019 bejson.com
 */
package com.xr.entity;
import java.util.List;
import java.util.Date;

/**
 * Auto-generated: 2019-12-01 19:43:41
 *
 * @author bejson.com (i@bejson.com)
 * @website http://www.bejson.com/java2pojo/
 */
public class FlightInfos {

    private String airlineCompany;
    private String leaveBuilding;
    private List<String> transferList;
    private String leavePort;
    private String arTime;
    private String tkTime;
   private LowestPriceInfo lowestPriceInfo;
    private String arriveCity;
    private String leaveCity;
    private String flightNo;
    private int onTimeRate;
    private String arrivePort;
    private String arriveBuilding;
    public void setAirlineCompany(String airlineCompany) {
        this.airlineCompany = airlineCompany;
    }
    public String getAirlineCompany() {
        return airlineCompany;
    }

    public void setLeaveBuilding(String leaveBuilding) {
        this.leaveBuilding = leaveBuilding;
    }
    public String getLeaveBuilding() {
        return leaveBuilding;
    }

    public void setTransferList(List<String> transferList) {
        this.transferList = transferList;
    }
    public List<String> getTransferList() {
        return transferList;
    }

    public void setLeavePort(String leavePort) {
        this.leavePort = leavePort;
    }
    public String getLeavePort() {
        return leavePort;
    }

    public void setArTime(String arTime) {
        this.arTime = arTime;
    }
    public String getArTime() {
        return arTime;
    }

    public void setTkTime(String tkTime) {
        this.tkTime = tkTime;
    }
    public String getTkTime() {
        return tkTime;
    }

    public void setLowestPriceInfo(LowestPriceInfo lowestPriceInfo) {
        this.lowestPriceInfo = lowestPriceInfo;
    }
    public LowestPriceInfo getLowestPriceInfo() {
        return lowestPriceInfo;
    }

    public void setArriveCity(String arriveCity) {
        this.arriveCity = arriveCity;
    }
    public String getArriveCity() {
        return arriveCity;
    }

    public void setLeaveCity(String leaveCity) {
        this.leaveCity = leaveCity;
    }
    public String getLeaveCity() {
        return leaveCity;
    }

    public void setFlightNo(String flightNo) {
        this.flightNo = flightNo;
    }
    public String getFlightNo() {
        return flightNo;
    }

    public void setOnTimeRate(int onTimeRate) {
        this.onTimeRate = onTimeRate;
    }
    public int getOnTimeRate() {
        return onTimeRate;
    }

    public void setArrivePort(String arrivePort) {
        this.arrivePort = arrivePort;
    }
    public String getArrivePort() {
        return arrivePort;
    }

    public void setArriveBuilding(String arriveBuilding) {
        this.arriveBuilding = arriveBuilding;
    }
    public String getArriveBuilding() {
        return arriveBuilding;
    }

}
