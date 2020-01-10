package com.xr.dao;

import com.xr.entity.Admin;
import com.xr.entity.AdminRole;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface AdminLogMapper {
    public List<Map<String,Object>> selectuser();
    public  int deleteuser(int id);
    public  int stopuser(int id);
    public  int editbyselectid(String rname);
    public  int edit(Admin admin);
    public  int adduser(Admin admin);
    public  List<AdminRole> queryallrole(AdminRole adminRole);
    public List<Map<String,Object>> selectuserwhere(Admin admin);
}