package com.swp.core.support;

import java.io.*;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * DESCRIPTION：   基本的通用的工具支持类，包括一系列常用方法的封装，为了类提供便捷的调用方式。
 *
 * 1、判断对象是否为空
 * 2、对象转换为String
 * 3、获取 UUID 主键，长度32位，且为大写模式
 *
 * 4、对字符串进行Base64编码
 * 5、对已经进行了base64编码的字符串进行解码
 * 6、对字符串进行MD5加密
 *
 * 7、获取系统当前的日期
 * 8、时间戳转换为指定格式的日期
 * 9、日期通过指定格式转换为时间戳
 *
 * 10、从指定文件中读取文件内容
 * 11、将内容写入指定的文件中
 * 12、读取配置 properties 文件中的值
 * 13、读取指定路径 properties 文件中的值，会从 classpath 路径下进行查找资源文件
 *
 * @ProjectName: swp-blog
 * @Package: com.swp.core.support
 * @Author: Siwanper
 * @CreateDate: 2018/7/22 下午2:58
 * @Version: 1.0
 * <p>Copyright: Copyright (c) 2018</p>
 */
public class BaseSupport {

    /**
     * 判断对象是否为空
     * @method      isNull
     * @author      Siwanper
     * @version
     * @param obj   需要进行判断的对象
     * @return      boolean
     * @exception
     * @date        2018/7/23 下午10:15
     */
    public boolean isNull(Object obj){

        if (null == obj){
            return true;
        }
        if (obj instanceof String){
            String str = (String) obj;
            return str.isEmpty() ? true : false;
        }
        if (obj instanceof List){
            List<?> list = (List<?>) obj;
            return list.isEmpty() ? true : false;
        }
        if (obj instanceof Map){
            Map<?,?> map = (Map<?, ?>) obj;
            return map.isEmpty() ? true : false;
        }
        if (obj instanceof Set){
            Set<?> set = (Set<?>) obj;
            return set.isEmpty() ? true : false;
        }
        return false;
    }

    /**
     * 对象转换为String
     *
     * @method      obj2Str
     * @author      作者姓名
     * @version
     * @param obj 需要转换的对象
     * @return      java.lang.String
     * @exception
     * @date        2018/7/23 下午10:18
     */
    public String obj2Str(Object obj){
        return null == obj ? "" : obj.toString();
    }

    /**
     * 获取 UUID 主键，长度32位，且为大写模式
     *
     * @method      getUUID
     * @author      Siwanper
     * @param
     * @return      java.lang.String
     * @exception
     * @date        2018/7/23 下午10:22
     */
    public String getUUID(){
        return UUID.randomUUID().toString().replaceAll("-","").toUpperCase();
    }

    /**
     * 对字符串进行Base64编码
     *
     * @method      base64Encoder
     * @author      Siwanper
     * @param str   需要编码的字符串
     * @return      编码后的结果字符串
     * @exception
     * @date        2018/7/23 下午10:27
     */
    public String base64Encoder(String str) {
        if (this.isNull(str)){
            return null;
        }
        return Base64.getUrlEncoder().encodeToString(str.getBytes());
    }

    /**
     * 对已经进行了base64编码的字符串进行解码
     *
     * @method      base64Decoder
     * @author      Siwanper
     * @param str   base64编码后的字符串
     * @return      base64解码后的字符串
     * @exception
     * @date        2018/7/23 下午10:31
     */
    public String base64Decoder(String str) {
        if (this.isNull(str)){
            return null;
        }
        return new String(Base64.getUrlDecoder().decode(str.getBytes()), StandardCharsets.UTF_8);
    }

    /**
     * 对字符串进行MD5加密
     *
     * @method      md5
     * @author      Siwanper
     * @param str
     * @return      java.lang.String
     * @exception
     * @date        2018/7/23 下午10:35
     */
    public String md5(String str) {
        if (this.isNull(str)){
            return null;
        }
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            return new BigInteger(1,md.digest()).toString(16).toUpperCase();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     *
     * 获取系统当前的日期
     *
     * @param pattern 需要获取系统时间的格式 如：yyyy-MM-dd HH:mm:ss
     * @return String 返回格式化后的时间
     */
    public String currentDate(String pattern) {
        if (this.isNull(pattern)){
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(new Date());
    }

    /**
     * 时间戳转换为指定格式的日期
     *
     * @param timestamp 时间戳
     * @param pattern   指定的时间格式
     * @return 格式化后的日期
     */
    public String timeStamp2Date(String timestamp, String pattern) {
        if (this.isNull(timestamp) || this.isNull(pattern)){
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(new Date(Long.valueOf(timestamp)));
    }

    /**
     * 日期通过指定格式转换为时间戳
     *
     * @param dataStr   需要进行转换的日期字符串
     * @param pattern   日期的格式
     * @return  转换后的时间戳
     */
    public  String date2TimeStamp(String dataStr, String pattern) {
        if (this.isNull(dataStr) || this.isNull(pattern)){
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        try {
            long timestamp = sdf.parse(dataStr).getTime();
            return String.valueOf(timestamp);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 日期通过指定格式转换为date类型
     *
     * @param dateStr
     * @param pattern
     * @return
     */
    public Date dateStr2date(String dateStr, String pattern){
        if (this.isNull(dateStr) || this.isNull(pattern)){
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        try {
            long timestamp = sdf.parse(dateStr).getTime();
            return new Date(timestamp);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     *
     * 从指定文件中读取文件内容
     *
     * @param filePath 文件路径（绝对路径）
     * @return 读取到的内容
     */
    public String readFromFile(String filePath){
        if (this.isNull(filePath)){
            return null;
        }
        try {
            StringBuffer stringBuffer = new StringBuffer();
            File file = new File(filePath); // 指定要读取的文件
            FileReader fileReader = new FileReader(file); // 获取该文件的输入流
            char[] bb =new char[1024]; // 用来保存每次要读取的字符
            int n; // 每次读取到的字符长度
            while ((n = fileReader.read(bb)) != -1){
                stringBuffer.append(new String(bb,0,n));
            }
            fileReader.close(); // 关闭流释放连接
            return stringBuffer.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将内容写入指定的文件中（写入会覆盖原有的内容，可以现读取在合并写入）
     * @param content
     * @param filePath
     */
    public void writeToFile(String content, String filePath){
        if (!this.isNull(content) && !this.isNull(filePath)){
            try {
                generateFile(filePath);
                File file = new File(filePath); // 要写入的文件
                FileWriter writer = new FileWriter(file); // 获取该文件的输入流
                writer.write(content); // 写内容
                writer.flush(); // 清空缓冲区，立即将输出流里的内容写到文件里
                writer.close(); // 关闭输出流，释放资源
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     *
     * 生成指定路径文件夹，先判断文件夹是否存在，如果不存在则创建对应目录的文件夹，如果存在则不进行任何操作
     *
     * @param path  指定文件路径
     */
    public void generatePath(String path){
        if (!this.isNull(path)){
            File file = new File(path);
            if (!file.exists() && !file.isDirectory()){
                file.mkdirs();
            }
        }
    }

    /**
     *
     * 生成指定文件，如果文件不存在则直接创建文件，如果文件存在则不进行任何操作。
     *
     * @param path
     */
    public void generateFile(String path){
        if (!this.isNull(path)){
            File file = new File(path);
            if (!file.exists()){
                try {
                    file.createNewFile();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     *
     * 读取配置 properties 文件中的值，读取classpath下 /properties/setting.properties 中的值
     *
     * @param key 需要读取的key
     * @return 返回key对应的值
     */
    public String propertiesValue(String key){
        if (this.isNull(key)){
            return null;
        }

        try {
            Properties properties = new Properties();
            InputStream inputStream = this.getClass().getResourceAsStream("/properties/setting.properties");
            properties.load(inputStream);
            return properties.getProperty(key);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     *
     * 读取指定路径 properties 文件中的值，会从 classpath 路径下进行查找资源文件
     *
     * @param resource 资源文件路径（对应 classpath 中的路径）
     * @param key 资源文件中key值
     * @return 读取key对应的value值
     */
    public String propertiesValue(String resource, String key){
        if (this.isNull(resource) || this.isNull(key)){
            return null;
        }
        try {
            Properties properties = new Properties();
            InputStream inputStream = this.getClass().getResourceAsStream(resource);
            properties.load(inputStream);
            return properties.getProperty(key);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

}
