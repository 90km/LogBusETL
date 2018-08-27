package etl;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import util.ConvertBase;
import util.DateUtil;

import java.io.IOException;

public class OnlineConvert extends ConvertBase {

    /**
     * 清洗子类的构造函数，用来传入日志清洗的输入输出流.
     *
     * @param input 输入数据的路径
     * @param output 输出数据的路径
     * @throws IOException I/O异常
     */
    public OnlineConvert(String input, String output) throws IOException {
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
            JsonObject userProperty = new JsonObject();
            //// 传入一个事件#type
            userProperty.addProperty("#type", "track");
            //// 必须配置EventName
            userProperty.addProperty("#event_name", "KP_online_new");
            try {
                // 创建一个包含原始json串的json对象
                object = (JsonObject) parser.parse(line);

                //// 将ip置换为#ip
                userProperty.addProperty("#ip", "52.77.60.201");
                //// 将account置换为#account_id
                userProperty.addProperty("#account_id", "0001");
                //// 将timeDateTimeStr置换为#time
                String time = DateUtil.timeStamp2Date(object.get("time").getAsString());
                //System.out.println("insert: "+time);
                userProperty.addProperty("#time", time);

                //// 增加property属性下的属性组
                JsonObject language = new JsonObject();
                language.addProperty("cid", object.get("cid").getAsInt());
                language.addProperty("sid", object.get("sid").getAsInt());
                language.addProperty("count_all", object.get("count_all").getAsInt());
                userProperty.add("properties", language);
                ////^^^^

                // 将json对象转化成json字符串存储
                ws = userProperty.toString();
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
