package com.stuff.manage.data;
import java.util.Date;
public class LoginResult {
    private String md5Result;
    private String nowTime;
    private String ret;
    private String message;
    public void setMd5Result(String md5Result) {
        this.md5Result = md5Result;
    }
    public String getMd5Result() {
        return md5Result;
    }

    public void setNowTime(String nowTime) {
        this.nowTime = nowTime;
    }
    public String getNowTime() {
        return nowTime;
    }

    public void setRet(String ret) {
        this.ret = ret;
    }
    public String getRet() {
        return ret;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    public String getMessage() {
        return message;
    }
}


