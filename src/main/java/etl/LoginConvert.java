package etl;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import util.ConvertBase;
import util.DateUtil;

import java.io.IOException;

public class LoginConvert extends ConvertBase {

    /**
     * 清洗子类的构造函数，用来传入日志清洗的输入输出流.
     *
     * @param input 输入数据的路径
     * @param output 输出数据的路径
     * @throws IOException I/O异常
     */
    public LoginConvert(String input, String output) throws IOException {
        super(input, output);
    }

    /**
     * JSON格式清洗.
     */
    public void jsonConvert() throws IOException {
        String line;
        String ws;
        JsonObject object;

        while ((line = br.readLine()) != null) {
            JsonParser parser = new JsonParser();
            JsonObject newObject = new JsonObject();
            // 传入一个事件#type
            newObject.addProperty("#type", "track");
            // 必须配置EventName
            newObject.addProperty("#event_name", "KP_login_new");
            // 将json对象转化成json字符串存储
            try {
                // 创建一个包含原始json串的json对象
                object = (JsonObject) parser.parse(line);

                // 将ip置换为#ip
                newObject.addProperty("#ip", object.get("ip").getAsString());
                // 将account置换为#account_id
                newObject.addProperty("#account_id", object.get("account").getAsString());
                // 将timeDateTimeStr置换为#time
                newObject.addProperty("#time", DateUtil
                    .convertTimeZone(object.get("timeDateTimeStr").getAsString()));
                // 增加property属性下的属性组
                JsonObject userProperty = new JsonObject();
                userProperty.addProperty("cid", object.get("cid").getAsInt());
                userProperty.addProperty("sid", object.get("sid").getAsInt());
                userProperty.addProperty("pid", object.get("pid").getAsInt());
                userProperty.addProperty("type", object.get("type").getAsInt());
                userProperty.addProperty("ispay", object.get("ispay").getAsInt());
                userProperty.addProperty("level", object.get("level").getAsInt());
                userProperty.addProperty("vip", object.get("vip").getAsInt());
                userProperty.addProperty("mark", object.get("mark").getAsInt());
                userProperty.addProperty("sign", object.get("sign").getAsString());
                userProperty.addProperty("device", object.get("device").getAsInt());
                userProperty.addProperty("guest", object.get("guest").getAsInt());
                userProperty.addProperty("mac", object.get("mac").getAsString());
                userProperty.addProperty("agent", object.get("agent").getAsString());
                newObject.add("properties", userProperty);
                //^^
                ws = newObject.toString();
                bw.write(ws);
                bw.newLine();
                bw.flush();
            } catch (Exception ee) {
                System.out.println(line);
            }
        }
        br.close();
        bw.close();
        //^^^
    }
}
