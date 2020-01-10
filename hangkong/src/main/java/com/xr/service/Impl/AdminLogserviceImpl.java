package com.xr.service.Impl;

import com.xr.dao.AdminLogMapper;
import com.xr.entity.Admin;
import com.xr.entity.AdminRole;
import com.xr.service.AdminLogservice;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("AdminLogservice")
public class AdminLogserviceImpl  implements AdminLogservice {
    @Resource
    private AdminLogMapper adminLogMapper;
    @Override
    public List<Map<String,Object>> selectuser() {
        return adminLogMapper.selectuser();
    }

    @Override
    public int deleteuser(int id) {
        return adminLogMapper.deleteuser(id);
    }

    @Override
    public int stopuser(int id) {
        return adminLogMapper.stopuser(id);
    }

    @Override
    public int editbyselectid(String rname) {
        return adminLogMapper.editbyselectid(rname);
    }

    @Override
    public int edit(Admin admin) {
        return adminLogMapper.edit(admin);
    }



    @Override
    public int adduser(Admin admin) {
        return adminLogMapper.adduser(admin);
    }

    @Override
    public  List<AdminRole> queryallrole(AdminRole adminRole) {
        return adminLogMapper.queryallrole(adminRole);
    }

    @Override
    public List<Map<String, Object>> selectuserwhere(Admin admin) {
        return adminLogMapper.selectuserwhere(admin);
    }

}
