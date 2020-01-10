/**
 * Copyright 2019 bejson.com
 */
package com.xr.entity;
import java.util.List;

/**
 * Auto-generated: 2019-12-01 19:43:41
 *
 * @author bejson.com (i@bejson.com)
 * @website http://www.bejson.com/java2pojo/
 */
public class JsonRootBean {

    private String msg;
    private int errCode;
    private List<FlightInfos> flightInfos;
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public String getMsg() {
        return msg;
    }

    public void setErrCode(int errCode) {
        this.errCode = errCode;
    }
    public int getErrCode() {
        return errCode;
    }

    public void setFlightInfos(List<FlightInfos> flightInfos) {
        this.flightInfos = flightInfos;
    }
    public List<FlightInfos> getFlightInfos() {
        return flightInfos;
    }

}