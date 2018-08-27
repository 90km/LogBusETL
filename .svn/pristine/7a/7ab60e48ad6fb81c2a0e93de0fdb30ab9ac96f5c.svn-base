package util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

/**
 * 日志格式清洗的基类.
 */
public abstract class ConvertBase {

    public BufferedReader br;   // 输入流
    public BufferedWriter bw;   // 输出流

    public BufferedReader getBr() {
        return br;
    }

    public void setBr(BufferedReader br) {
        this.br = br;
    }

    public BufferedWriter getBw() {
        return bw;
    }

    public void setBw(BufferedWriter bw) {
        this.bw = bw;
    }

    /**
     * 清洗基类的构造函数，用来获得日志清洗的输入输出流.
     *
     * @param input 输入数据的路径
     * @param output 输出数据的路径
     * @throws IOException I/O异常
     */
    public ConvertBase(String input, String output) throws IOException {
        br = new BufferedReader(new FileReader(input));
        bw = new BufferedWriter(new FileWriter(output));
    }

    /**
     * JSON日志格式清洗方法，需要子类来实现.
     */
    public abstract void jsonConvert() throws IOException;
}
