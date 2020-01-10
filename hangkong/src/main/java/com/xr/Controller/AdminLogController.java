package com.xr.Controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.xr.entity.*;
import com.xr.service.AdminLogservice;
import com.xr.uitl.HttpUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RestController
public class AdminLogController {
    @Resource
    private AdminLogservice adminLogservice;

    @RequestMapping("/flyapi")
    public void   flyapi( HttpServletResponse responses) {
        responses.setCharacterEncoding("utf-8");
        responses.setContentType("text/html:charset=utf-8");
        String host = "http://airinfo.market.alicloudapi.com";
        String path = "/airInfos";
        String method = "POST";
        String appcode = "38d7010a8f7243619829a3fa69ce5375";
        Map<String, String> headers = new HashMap<String, String>();
        //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
        headers.put("Authorization", "APPCODE " + appcode);
        //根据API的要求，定义相对应的Content-Type
        headers.put("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        Map<String, String> querys = new HashMap<String, String>();
        Map<String, String> bodys = new HashMap<String, String>();
        bodys.put("arrive_code", "BJS");
        bodys.put("leave_code", "CSX");
        bodys.put("query_date", "2019-12-06");


        try {
            /**
             * 重要提示如下:
             * HttpUtils请从
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
             * 下载
             *
             * 相应的依赖请参照
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
             */
            HttpResponse response = HttpUtils.doPost(host, path, method, headers, querys, bodys);
            System.out.println(response.toString());
            //获取response的body
            //System.out.println(EntityUtils.toString(response.getEntity()));
            String DX =  EntityUtils.toString(response.getEntity());
            List<FlightInfos> list = new ArrayList<>();

            System.out.println(DX);
            JSONObject jsonObject= JSONObject.fromObject(DX);
            int errCode = jsonObject.getInt("errCode");
            JSONArray result = jsonObject.getJSONArray("flightInfos");
            for (int i = 0; i < result.size(); i++) {
                String airlineCompany = result.getJSONObject(i).getString("airlineCompany");
                String leaveCity = result.getJSONObject(i).getString("leaveCity");
                String arriveCity = result.getJSONObject(i).getString("arriveCity");
                String arTime = result.getJSONObject(i).getString("arTime");
                String tkTime = result.getJSONObject(i).getString("tkTime");
                String flightNo = result.getJSONObject(i).getString("flightNo");
                int onTimeRate = result.getJSONObject(i).getInt("onTimeRate");
                FlightInfos f = new FlightInfos();
                f.setAirlineCompany(airlineCompany);
                f.setLeaveCity(leaveCity);
                String format = arTime;
                String format1 = tkTime;
                f.setArTime(format);
                f.setTkTime(format1);
                f.setFlightNo(flightNo);
                f.setArriveCity(arriveCity);
                f.setOnTimeRate(onTimeRate);
                list.add(f);
            }

            /*JsonRootBean HK = (JsonRootBean) JSONObject.toBean(jsonObject,JsonRootBean.class);

           List<FlightInfos> flightInfos = HK.getFlightInfos();*/

            StringBuffer sb = new StringBuffer("{\"code\":0,\"msg\":\"\",\"count\":1000,\"data\":[");
            // 拼接成json格式
            for (FlightInfos info : list) {
                sb.append("{\"airlineCompany\":"+"\""+info.getAirlineCompany()+"\",\"arTime\":\""+info.getArTime()+"\",\"tkTime\":"+"\""+info.getTkTime()+"\",\"leaveCity\":\""+info.getLeaveCity()+"\",\"arriveCity\":"+"\""+info.getArriveCity()+"\",\"flightNo\":\""+info.getFlightNo()+"\",\"onTimeRate\":\""+info.getOnTimeRate()+"\"},");

            }




            // 去掉最后一个,号
            sb.append("]}");
            sb.deleteCharAt(sb.lastIndexOf(","));
            try {
                //PrintWriter out 必须要写在方法里在HttpServletResponse之后出现 否则会出现乱码
                System.out.println(sb);
                PrintWriter out = responses.getWriter();
                out.print(sb);
                out.flush();
                out.close();
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("/deleteuser")
    public void deleteuser( HttpServletResponse response,int id){
        adminLogservice.deleteuser(id);
    }
    @RequestMapping("/stopuser")
    public void stopuser( HttpServletResponse response,int id){
        adminLogservice.stopuser(id);
    }
    @RequestMapping("/adduser")
    public void adduser( HttpServletResponse responseAdmin,Admin admin,String rname){
        System.out.println(admin.getSex());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        ParsePosition pos = new ParsePosition(8);
        Date date = df.parse(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()), pos);
        admin.setAddTime(date);
        admin.setRoleId(Integer.parseInt(rname));
        System.out.println(admin.getRoleId());
        adminLogservice.adduser(admin);
    }
    @RequestMapping("/edit")
    public void edit( HttpServletResponse response,String sex,Admin admin,String rname){
       int  rid = editbyselectid(rname);
       admin.setRoleId(rid);
       adminLogservice.edit(admin);
    }
    public int editbyselectid(String rname){
        return adminLogservice.editbyselectid(rname);
    }
    @RequestMapping("queryallrole")
    public void queryallrole(HttpServletResponse response, AdminRole adminRole){
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html:charset=utf-8");
        List<AdminRole> q = adminLogservice.queryallrole(adminRole);
        StringBuffer sb = new StringBuffer("[");
        for (AdminRole r : q) {
            sb.append("{\"id\":\"" + r.getId() + "\",\"name\":\"" + r.getName() + "\"},");
        }
        sb.append("]");
        sb.deleteCharAt(sb.lastIndexOf(","));
        try {
            //PrintWriter out 必须要写在方法里在HttpServletResponse之后出现 否则会出现乱码
            PrintWriter out = response.getWriter();
            out.print(sb);
            out.flush();
            out.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    @RequestMapping("/selectuserwhere")
    public void selectuserwhere( HttpServletResponse response,int limit,int page,String yh,String xm,String sj){
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html:charset=utf-8");
        Page p = PageHelper.startPage(page, limit);
        Admin admin = new Admin();
        if(yh==""){
            yh=null;
        }
        if(xm==""){
            xm=null;
        }
        if(sj==""){
            sj=null;
        }
        admin.setUsername(yh);
        admin.setName(xm);
        admin.setTel(sj);
        System.out.println(yh+""+xm+""+sj);
        List<Map<String,Object>> list = adminLogservice.selectuserwhere(admin);
        StringBuffer sb = new StringBuffer("{\"code\":0,\"msg\":\"\",\"count\":1000,\"data\":[");
        // 拼接成json格式
        for (Map<String, Object> m : list) {
            Set<String> set = m.keySet();
            Iterator<String> iterator = set.iterator();
            sb.append("{");
            while (iterator.hasNext()) {
                String s = iterator.next();
                Object o = m.get(s);
                if(o.toString()=="true"){
                    o = "正常";
                } if(o.toString()=="false") {
                    o = "已停用";
                }
                System.out.println(s+"  "+o);
                sb.append("\"" + s + "\":\"" + o + "\",");
            }
            sb.deleteCharAt(sb.lastIndexOf(","));;
            sb.append("},");
        }
       /* for (Admin m : list) {
            sb.append("{\"username\":\"" + m.getUsername()+ "\",\"name\":\"" + m.getName()+ "\",\"age\":\"" + m.getAge()+"\",\"tel\":\"" + m.getTel()+"\",\"qq\":\"" + m.getQq()+"\",\"state\":\"" + m.getState()+"\",\"add_time\":\"" + m.getAddTime()+"\",\"id\":\"" + m.getId()+ "\"},");
        }*/
        // 去掉最后一个,号
        sb.append("]}");
        sb.deleteCharAt(sb.lastIndexOf(","));
        try {
            //PrintWriter out 必须要写在方法里在HttpServletResponse之后出现 否则会出现乱码
            PrintWriter out = response.getWriter();
            out.print(sb);
            out.flush();
            out.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    @RequestMapping("/selectuser")
    public void selectuser( HttpServletResponse response,int limit,int page){
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html:charset=utf-8");
        Page p = PageHelper.startPage(page, limit);
        List<Map<String,Object>> list = adminLogservice.selectuser();
        StringBuffer sb = new StringBuffer("{\"code\":0,\"msg\":\"\",\"count\":1000,\"data\":[");
        // 拼接成json格式
        for (Map<String, Object> m : list) {
            Set<String> set = m.keySet();
            Iterator<String> iterator = set.iterator();
            sb.append("{");
            while (iterator.hasNext()) {
                String s = iterator.next();
                Object o = m.get(s);
                if(o.toString()=="true"){
                    o = "正常";
                } if(o.toString()=="false") {
                    o = "已停用";
                }

                sb.append("\"" + s + "\":\"" + o + "\",");
            }
            sb.deleteCharAt(sb.lastIndexOf(","));;
            sb.append("},");
        }
       /* for (Admin m : list) {
            sb.append("{\"username\":\"" + m.getUsername()+ "\",\"name\":\"" + m.getName()+ "\",\"age\":\"" + m.getAge()+"\",\"tel\":\"" + m.getTel()+"\",\"qq\":\"" + m.getQq()+"\",\"state\":\"" + m.getState()+"\",\"add_time\":\"" + m.getAddTime()+"\",\"id\":\"" + m.getId()+ "\"},");
        }*/
        // 去掉最后一个,号
        sb.append("]}");
        sb.deleteCharAt(sb.lastIndexOf(","));
        try {
            //PrintWriter out 必须要写在方法里在HttpServletResponse之后出现 否则会出现乱码
            PrintWriter out = response.getWriter();
            out.print(sb);
            out.flush();
            out.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
