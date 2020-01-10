/**
 * Copyright 2019 bejson.com
 */
package com.xr.entity;

/**
 * Auto-generated: 2019-12-01 19:43:41
 *
 * @author bejson.com (i@bejson.com)
 * @website http://www.bejson.com/java2pojo/
 */
public class LowestPriceInfo {

    private double discount;
    private int price;
    private int standardPrice;
    private int oilFee;
    private int buildTax;
    public void setDiscount(double discount) {
        this.discount = discount;
    }
    public double getDiscount() {
        return discount;
    }

    public void setPrice(int price) {
        this.price = price;
    }
    public int getPrice() {
        return price;
    }

    public void setStandardPrice(int standardPrice) {
        this.standardPrice = standardPrice;
    }
    public int getStandardPrice() {
        return standardPrice;
    }

    public void setOilFee(int oilFee) {
        this.oilFee = oilFee;
    }
    public int getOilFee() {
        return oilFee;
    }

    public void setBuildTax(int buildTax) {
        this.buildTax = buildTax;
    }
    public int getBuildTax() {
        return buildTax;
    }

}