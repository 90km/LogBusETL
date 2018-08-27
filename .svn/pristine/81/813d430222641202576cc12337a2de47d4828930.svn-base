package etl;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import util.ConvertBase;
import util.DateUtil;

import java.io.IOException;

public class EventConvert extends ConvertBase {

    /**
     * 清洗子类的构造函数，用来传入日志清洗的输入输出流.
     *
     * @param input 输入数据的路径
     * @param output 输出数据的路径
     * @throws IOException I/O异常
     */
    public EventConvert(String input, String output) throws IOException {
        super(input, output);
        br = super.getBr();
        bw = super.getBw();
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
            newObject.addProperty("#event_name", "KP_event_new");
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
                userProperty.addProperty("pid", object.get("pid").getAsBigInteger());
                userProperty.addProperty("eid", object.get("eid").getAsBigInteger());
                userProperty.addProperty("ispay", object.get("ispay").getAsInt());
                userProperty.addProperty("type", object.get("type").getAsInt());
                userProperty.addProperty("count", object.get("count").getAsInt());
                userProperty.addProperty("mark", object.get("mark").getAsInt());
                newObject.add("properties", userProperty);
                //^^

                // 将json对象转化成json字符串存储
                ws = newObject.toString();
                bw.write(ws);
                bw.newLine();
                bw.flush();
            } catch (Exception format) {
                System.out.println(line);
            }
        }
        br.close();
        bw.close();
        //^^^
    }
}
