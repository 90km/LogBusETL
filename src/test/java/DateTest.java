import java.text.ParseException;
import org.junit.Test;
import util.DateUtil;

public class DateTest {

    @Test
    public void test1(){

        // 对纯数字字符串的测试，如何通过数字字符串转化为日期格式，并最终适配日期工具类
        // 实例：1527436800

        String time = new String("1527436800");
        String covertTime = null;
        try {
            covertTime = DateUtil.timeStamp2Date(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        //String covertTime = DateUtil.convertTimeZone(time);
        System.out.println("Format TimeStamp To Date:" + covertTime);
    }
}
