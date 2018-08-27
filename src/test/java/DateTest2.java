import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import org.junit.Test;
import util.DateUtil;

public class DateTest2 {

    @Test
    public void test1() throws ParseException {
        Date parse;
        String format = "yyyy-MM-dd HH:mm:ss";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        String date = "2018-05-27 17:00:00";
/*
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+1:00"));
        parse = sdf.parse(date);
        System.out.println("2: "+parse);
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+8:00"));
        System.out.println("3: "+sdf.format(parse));
*/
        String s = DateUtil.convertTimeZone(date);
        System.out.println("转换后的时间为：" + s);

    }

}
