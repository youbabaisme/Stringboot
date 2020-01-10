package com.xr.redis;

import redis.clients.jedis.Jedis;

import java.util.Set;

public class test {
    public static void main(String[] args) {
        Jedis jedis = new Jedis("192.168.32.128", 6379);
        Set<String> keys = jedis.keys("*");
        for (String key : keys) {
            System.out.println(key);
        }
    }
}
