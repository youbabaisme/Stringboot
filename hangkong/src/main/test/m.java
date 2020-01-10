
import com.xr.entity.JsonRootBean;
import com.xr.uitl.HttpUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

public class m {
    @Autowired
    private JsonRootBean JS;
    public static void main(String[] args) {
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
        bodys.put("query_date", "2019-12-02");


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
            JSONObject jsonObject= JSONObject.fromObject(DX);
            JsonRootBean HK = (JsonRootBean) JSONObject.toBean(jsonObject,JsonRootBean.class);
            System.out.println(HK.getFlightInfos().get(1));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
