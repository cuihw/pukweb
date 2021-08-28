package com.stuff.manage.tools;

import com.google.gson.Gson;
import com.stuff.manage.data.model.LoginResponse;

import java.io.UnsupportedEncodingException;

public class StringUtils {
    public static final String[] ENCODES = new String[]{"UTF-8", "GBK", "GB2312", "ISO-8859-1", "ISO-8859-2"};
    /**
     * 获取字符串是什么编码，例如返回的值有：UTF-8，GBK，ISO-8859-1等
     *
     * @param str
     * @return
     */
    public static String getEncode(String str) {
        byte[] data = str.getBytes();
        byte[] b = null;
        a:
        for (int i = 0; i < ENCODES.length; i++) {
            try {
                b = str.getBytes(ENCODES[i]);
                if (b.length != data.length) {
                    continue;
                }
                for (int j = 0; j < b.length; j++) {
                    if (b[j] != data[j]) {
                        continue a;
                    }
                }
                return ENCODES[i];
            } catch (UnsupportedEncodingException e) {
                continue;
            }
        }
        return null;
    }

    public static <T> T getDataFromString(String str, Class<T> cls){
        Gson gson = new Gson();
        T t = gson.fromJson(str, cls);
        return t;
    }
}
